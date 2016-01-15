require 'nokogiri'
require 'open-uri'
require 'fileutils'
require 'open3'

require 'spec_helper'
require_relative '../lib/grubbers'

RSpec.describe Grubbers do
  describe 'Units' do
    it 'has ImageGrubber module' do
      expect{Grubbers::ImageGrubber}.not_to raise_exception
      expect(Grubbers::ImageGrubber.class).to be(Module)
    end

    describe Grubbers::ImageGrubber do
      it 'has Grubber class' do
        expect{Grubbers::ImageGrubber::Grubber}.not_to raise_exception
        expect(Grubbers::ImageGrubber::Grubber.class).to be(Class)
      end

      it 'has ConsoleTool class' do
        expect{Grubbers::ImageGrubber::ConsoleTool}.not_to raise_exception
        expect(Grubbers::ImageGrubber::ConsoleTool.class).to be(Class)
      end


      describe Grubbers::ImageGrubber::Grubber do
        img_grubber = Grubbers::ImageGrubber::Grubber.new(
            'http://localhost:4567/',
            File.join(Dir.pwd, 'spec', 'output_files'),
            false
        )

        describe 'realization' do
          it 'has @resource_uri property' do
            expect(img_grubber).to respond_to(:resource_uri)
          end

          it '@resource_uri has Addressable::URI type' do
            expect(img_grubber.resource_uri.class).to be(Addressable::URI)
          end

          it 'has @output_path property' do
            expect(img_grubber).to respond_to(:output_path)
          end

          it '@output_path is an string' do
            expect(img_grubber.output_path.class).to be(String)
          end

          it 'has @output_files property' do
            expect(img_grubber).to respond_to(:output_files)
          end

          it '@output_files is an array' do
            expect(img_grubber.output_files.class).to be(Array)
          end

          it 'has @errors property' do
            expect(img_grubber).to respond_to(:errors)
          end

          it '@errors is an array' do
            expect(img_grubber.errors.class).to be(Array)
          end

          it 'has grub method' do
            expect(img_grubber).to respond_to(:grub)
            expect(img_grubber.methods).to include(:grub)
          end
          it 'has aborted_links property' do
            expect(img_grubber).to respond_to(:aborted_links)
          end

          it 'has passed_links property' do
            expect(img_grubber).to respond_to(:passed_links)
          end
        end

        context 'after the download process' do
          before { img_grubber.grub(false) }
          after  {
            img_grubber.output_files  = []
            img_grubber.passed_links  = []
            img_grubber.aborted_links = []
          }

          # HACK: i know that the test resource has one 404 image url and one 200 url
          # TODO (Rustam Ibragimov): make automatic parser (or.. not)
          let(:alive_links) { ['http://localhost:4567/test.png'] }
          let(:dead_links)  { ['http://localhost:4567/barmaleika.png'] }
          let(:alive_links_count)  { 1 }
          let(:beated_links_count) { 1 }

          it 'downloads all supported images from the test resource' do
            expect(img_grubber.output_files.length).to eq(alive_links_count)
          end

          it 'contains a set of file names of downloaded files' do
            expect(img_grubber.output_files).to eq(Dir.glob(File.join(img_grubber.output_path, '*')))
          end

          it 'drops dead and unsupported links' do
            expect(img_grubber.aborted_links).to eq(dead_links)
          end

          it 'pass alive image links' do
            expect(img_grubber.passed_links).to eq(alive_links)
          end

          it 'supports only image mime types'
        end
      end

      describe Grubbers::ImageGrubber::ConsoleTool do
        it 'has the parse method' do
          expect(Grubbers::ImageGrubber::ConsoleTool).to respond_to(:parse)
        end

        context 'when all arguments are setted' do
          subject(:options) { Grubbers::ImageGrubber::ConsoleTool.parse(['-u', 'http://localhost:4567', '-o', 'atata']) }

          it 'returns OpenStruct ARGV\'s arguments set' do
            expect(options.class).to be(OpenStruct)
          end

          describe 'OpenStruct result' do
            it 'contains #uri and #output_dir properties' do
              expect(options).to respond_to(:uri)
              expect(options).to respond_to(:output_dir)
            end

            it '#uri is string' do
              expect(options.uri.class).to be(String)
            end

            it '#output_dir is string' do
              expect(options.output_dir.class).to be(String)
            end
          end
        end

        context 'when the url argument is not setted in ARGV' do
          it 'raises OptionParser::MissingArgument exception' do
            expect{
              Grubbers::ImageGrubber::ConsoleTool.parse(['-o', 'atata'])
            }.to raise_exception(OptionParser::MissingArgument)
          end
        end
      end
    end
  end

  describe 'Integration' do
    # Dunno, how to implement this. So I used this method:
    #   1) make a process with the real program execution command
    #   2) handle stdoud and stderr
    #   3) compare stdoutstderr with expected values
    it 'program works good :D' do
      expected_output = [
        "ABORTED: http://localhost:4567/barmaleika.png\n",
        "DOWNLOADED: http://localhost:4567/test.png\n"
      ]

      output = []
      errout = []

      # Step One
      Open3.popen3("./scripts/grubber.rb -u http://localhost:4567/ -o spec/output_files") do |stdin, stdout, stderr|
        stdin.close
        # Step Two
        output = stdout.readlines
        errout = stderr.readlines
      end

      is_expected_output = output.map do |line|
        expected_output.include?(line)
      end.inject(true) do |injected, current_injected|
        injected && current_injected
      end

      # Step three
      expect(is_expected_output).to eq(true)
      expect(errout.length).to eq(0)
    end
  end
end
