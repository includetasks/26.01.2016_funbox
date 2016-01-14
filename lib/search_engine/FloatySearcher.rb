require 'set'

module SearchEngine
  class FloatySearcher < Searcher
    # @param data_set [LazyDataSet]
    # @param context [Symbol]
    def initialize(context, data_set)
      super(context, data_set)
    end

    # @param options [Hash]
    # @return [Set]
    def select(options)
      case options[:action]
        when '='
          @data_set[options[:value]].clone
        when '>'
          filtered_select((options[:value] + 0.01)..@data_set.max)
        when '>='
          filtered_select(options[:value]..@data_set.max)
        when '<'
          filtered_select(@data_set.min...options[:value])
        when '<='
          filtered_select(@data_set.min..options[:value])
        when '<<'
          filtered_select((options[:value].min + 0.01)..(options[:value].max - 0.01))
        when '<=<'
          filtered_select((options[:value].min)..(options[:value].max - 0.01))
        when '<<='
          filtered_select((options[:value].min + 0.1)..options[:value].max)
        when '<=<='
          filtered_select(options[:value].min..options[:value].max)
        else
          Set.new
      end
    end
  end
end
