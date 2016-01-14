require 'set'

module SearchEngine
  class SearchMachine
    attr_reader :started

    def initialize
      @searchers = {}
      @result = Set.new
    end

    # @param searcher [Searcher]
    def register_searcher(searcher)
      @searchers[searcher.context] = searcher
    end

    # @param context [Symbol]
    def unregister_searcher(context)
      @searchers.delete(context)
    end

    # @param context [Symbol]
    def get_searcher(context)
      @searchers[context]
    end

    # @param options [Hash]
    # @return [self]
    def select_by(options = {})
      factor_set = @searchers[options[:context]].select({
        action: options[:action],
        value:  options[:value]
      })

      fill_result factor_set
      self
    end

    # @return [Set]
    def get_result
      @started = false
      @result.clone
    end

    # @param subset [Set]
    def fill_result(subset)
      if @started
        @result &= subset
      else
        @result.clear
        @started = true
        @result.merge(subset)
      end
    end
  end
end
