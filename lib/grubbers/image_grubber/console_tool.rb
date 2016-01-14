require 'optparse'
require 'ostruct'

module Grubbers
  module ImageGrubber
    class ConsoleTool
      # Parse console arguments and return it in OpenStruct form
      # Supported options:
      #   -u (--uri) uri - URI of any web page
      #   -o (--output-dir) output_dir - Output dir for files
      #
      # @return [OpenStruct] Console arguments
      def self.parse(args)
        options            = OpenStruct.new
        options.uri        = nil
        options.output_dir = './images/'

        OptionParser.new do |opts|
          opts.banner = 'Usage: example.rb [options]'

          opts.on('-u', '--uri uri', String, 'Where are your images? :)') do |uri|
            options.uri = uri
          end

          opts.on('-o', '--output-dir [dir]', String, 'Where i should to save your pictures? (default: ./images/)') do |output_dir|
            options.output_dir = output_dir if output_dir
          end

          opts.on('-h', '--help', 'Display this screen') do
            puts opts
            exit
          end
        end.parse!(args)

        raise OptionParser::MissingArgument unless options.uri

        options
      end
    end
  end
end
