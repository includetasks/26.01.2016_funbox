require 'set'

module SearchEngine
  class Searcher
    attr_accessor :data_set
    attr_reader   :context, :min, :max

    # @param data_set [LazyDataSet]
    # @param context [Symbol]
    def initialize(context, data_set)
      @data_set = data_set
      @min      = data_set.min
      @max      = data_set.max
      @context  = context
    end

    # @param range [Range] The set of possible values
    # @return [Set] Subset of @data_set sets.
    def filtered_select(range)
      @data_set.keys.select{ |i| range.include?(i) }.inject(Set.new) do |memo, value|
        memo.merge(@data_set[value])
        memo
      end
    end

    # @param options [Hash]
    # @return [Set]
    def select(options)
      case options[:action]
        when '='
          @data_set[options[:value]].clone
        when '>'
          filtered_select((options[:value] + 1)..@data_set.max)
        when '>='
          filtered_select(options[:value]..@data_set.max)
        when '<'
          filtered_select(@data_set.min...options[:value])
        when '<='
          filtered_select(@data_set.min..options[:value])
        when '<<'
          filtered_select((options[:value].min + 1)...options[:value].max)
        when '<=<'
          filtered_select((options[:value].min)...options[:value].max)
        when '<=<='
          filtered_select((options[:value].min)..options[:value].max)
        when '<<='
          filtered_select((options[:value].min + 1)..options[:value].max)
        else
          Set.new
      end
    end
  end
end
