require 'set'

module SearchEngine
  class LazyDataSet
    include Enumerable

    attr_accessor :data_set
    attr_reader :min, :max

    # @param opts [Hash]
    def initialize(opts)
      @data_set = {}
      @min = opts[:min] || 0
      @max = opts[:max] || 1
    end

    # @param index [Mixed] Integer or other
    def [](index)
      if @data_set.key?(index)
        @data_set[index]
      else
        @data_set[index] = Set.new
        @data_set[index]
      end
    end

    # @param block [Proc]
    def each(&block)
      @data_set.each do |key, value|
        block.call({value: key, set: value})
      end
    end

    def keys
      @data_set.keys
    end
  end
end
