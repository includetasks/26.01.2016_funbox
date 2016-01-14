#!/usr/bin/env ruby
# encoding: UTF-8

require_relative '../lib/grubbers.rb'

options = Grubbers::ImageGrubber::ConsoleTool.parse(ARGV)
grubber = Grubbers::ImageGrubber::Grubber.new(options.uri, options.output_dir, true)
grubber.grub
