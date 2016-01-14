require 'nokogiri'
require 'digest'
require 'net/http'
require 'openssl'
require 'open-uri'
require 'open_uri_redirections'
require 'addressable/uri'

module Grubbers
  module ImageGrubber
    class Grubber
      ImageGrubberError = Class.new(StandardError)
      GrubInitError     = Class.new(ImageGrubberError)

      IMAGE_MIME_TYPES = [
        'image/x-windows-bmp',
        'image/vnd.dwg',
        'image/x-dwg',
        'image/fif',
        'image/florian',
        'image/vnd.fpx',
        'image/vnd.net-fpx',
        'image/g3fax',
        'image/gif',
        'image/x-icon',
        'image/ief',
        'image/jpeg',
        'image/pjpeg',
        'image/x-jps',
        'image/jutvision',
        'image/vasa',
        'image/naplps',
        'image/x-niff',
        'image/x-portable-bitmap',
        'image/x-pict',
        'image/x-pcx',
        'image/x-portable-graymap',
        'image/x-portable-greymap',
        'image/pict',
        'image/x-xpixmap',
        'image/png',
        'image/x-portable-anymap',
        'image/x-portable-pixmap',
        'image/x-quicktime',
        'image/cmu-raster',
        'image/x-cmu-raster',
        'image/vnd.rn-realflash',
        'image/x-rgb',
        'image/vnd.rn-realpix',
        'image/tiff',
        'image/x-tiff',
        'image/vnd.wap.wbmp',
        'image/x-xbitmap',
        'image/x-xbm',
        'image/xbm',
        'image/vnd.xiff',
        'image/xpm',
        'image/x-xwd',
        'image'
      ]

      attr_accessor :resource_uri, :output_path, :output_files, :errors, :aborted_links, :passed_links

      # @param uri [String]
      # @param output_path [String]
      # @param verbose [Boolean]
      def initialize(uri, output_path, verbose = true)
        @resource_uri = Addressable::URI.heuristic_parse(uri).normalize
        @resource_uri.port = 80 if @resource_uri.port.nil?

        @output_path   = create_image_dir(output_path)
        @output_files  = []
        @aborted_links = []
        @passed_links  = []
        @errors        = []
        @thread_pool   = ThreadGroup.new
        @verbose       = verbose
      end

      # Multi-thread image grubbing
      #
      # @return [Array] Array of saved file names (strings)
      def grub(verbose = true)
        @verbose = verbose
        grub_image_urls.each do |image_data|
          @thread_pool.add(Thread.new { fetch_image(image_data) })
        end
        @thread_pool.list.map(&:join)
        @output_files
      end

      protected

      # Creates (skip if directory is exists and avaliable to write).
      #
      # @param output_path [String] Directory path
      # @return [String] Fullname of directory
      def create_image_dir(output_path)
        if Dir.exists?(output_path)
          raise GrubInitError unless File.writable?(output_path)
        else
          Dir.mkdir(output_path) unless Dir.exist?(output_path)
        end
        File.join(output_path, File::SEPARATOR)
      rescue => e
        raise GrubInitError, e.message
      end

      # Processing of file image downloading.
      #
      # @param image_data [Hash] Hash in the next form: { file_name: String, image_url: Addressable::URI }
      def fetch_image(image_data)
        image_download(image_data[:image_uri], image_data[:file_name])
      rescue => e
        @errors << { uri: @resource_uri, errors: { fetch_image_error: e.message } }
      end

      # Downloads image file.
      #
      # @param img_uri [Addressable::URI] Image URI from image tag attribute
      # @param file_name [String] Full file name for file saving
      def image_download(img_uri, file_name)
        if self.is_image?(img_uri)
          File.open(file_name, 'w') do |file|
            IO.copy_stream(open(img_uri.to_s, allow_redirections: :all, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE), file)
            @output_files << file_name
            @passed_links << img_uri.to_s
            puts "DOWNLOADED: #{img_uri}" if @verbose
          end
        else
          @aborted_links << img_uri.to_s
          puts "ABORTED: #{img_uri}" if @verbose
        end
      rescue => e
        @errors << { uri: @resource_uri, errors: { fetch_image_error: e.message } }
      end

      # Checks if requested resource is an image.
      #
      # @param img_uri [Addressable::URI] Requested resource
      # @param redirect_timeout [Integer] Redirection depth... Go deeper..
      # @return [Boolean]
      def is_image?(img_uri, redirect_timeout = 10)
        is_image = false

        Net::HTTP.start(img_uri.host, img_uri.port, use_ssl: img_uri.scheme == 'https') do |http_base|

          http_req = Net::HTTP::Head.new(img_uri.request_uri)
          http_req['Cache-Control'] = 'no-cache'
          http_resp = http_base.request(http_req)

          if (http_resp.is_a?(Net::HTTPRedirection) || http_resp.is_a?(Net::HTTPMovedPermanently)) && redirect_timeout >= 0
            is_image = is_image?(Addressable::URI.heuristic_parse(http_resp.header['location']), --redirect_timeout)
          elsif http_resp.is_a?(Net::HTTPOK) && IMAGE_MIME_TYPES.include?(http_resp.content_type)
            is_image = true
          end
        end
        is_image
      rescue => e
        @errors << { uri: @resource_uri, errors: { fetch_image_error: e.message } }
      end

      # Generates a filename in MD5-hash form.
      #
      # @param image_source [String] Image source name (src from <img> tag)
      # @param output_path [String] Output path of new file (directory name)
      # @return [String] Generated filename
      def generate_file_name(image_source, output_path)
        file_name = ''
        file_name << output_path
        file_name << ((Digest::MD5.new) << image_source).to_s
        file_name << File.extname(image_source)
        file_name
      end

      # Grubs HTML page by Nokogiri Karate Do.
      #
      # @return [Array] parsed html content from uri
      def grub_image_urls
        image_tags = Nokogiri::HTML(
          open(@resource_uri, allow_redirections: :all, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE)
        ).css('img').to_a.uniq

        image_tags.map do |image_tag|
          image_uri  = Addressable::URI.parse(image_tag.attributes['src']).normalize

          # TODO (Rustam Ibragimov): drop this hack!
          # HACK (Rustam Ibragimov): ...if we not have '/' symbol in start...
          if image_uri.path[0] && (image_uri.path[0] != '/') && !image_uri.absolute?
            img_src = '/' << image_tag.attributes['src']
            image_uri = Addressable::URI.heuristic_parse(img_src).normalize
          end

          image_uri.scheme = @resource_uri.scheme if image_uri.scheme.nil?
          image_uri.host   = @resource_uri.host   if image_uri.host.nil?
          image_uri.port   = @resource_uri.port   if image_uri.port.nil?

          file_name = generate_file_name(image_uri.to_s, @output_path)

          { file_name: file_name, image_uri: image_uri }
        end.uniq
      end
    end
  end
end
