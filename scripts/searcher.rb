require 'set'
require 'pp'
require 'benchmark'
require_relative '../lib/search_engine'
include SearchEngine

# Create searchers
search_engine   = SearchMachine.new
sex_searcher    = Searcher.new(:sex,    LazyDataSet.new(min: 0, max: 1))
age_searcher    = Searcher.new(:age,    LazyDataSet.new(min: 0, max: 100))
height_searcher = Searcher.new(:height, LazyDataSet.new(min: 0, max: 300))
index_searcher  = Searcher.new(:index,  LazyDataSet.new(min: 0, max: 1_000_000))
salary_searcher = FloatySearcher.new(:salary, LazyDataSet.new(min: 0.0, max: 1_000_000.0))

# User data randomizer
randomize_user_data = -> do
  {
    sex:    rand(sex_searcher.min..sex_searcher.max),
    age:    rand(age_searcher.min..age_searcher.max),
    height: rand(height_searcher.min..height_searcher.max),
    index:  rand(index_searcher.min..index_searcher.max),
    salary: rand(salary_searcher.min..salary_searcher.max).round(2)
  }
end

# Object pool example (array of hashes based on user data randomizer): [{}, {}, ..., {}]
ppl = nil

initialization = Benchmark.measure do
  ppl = (0..1_000_000).inject([]) do |ppl, i|
    user = randomize_user_data.call

    sex_searcher.data_set[user[:sex]]       << i
    age_searcher.data_set[user[:age]]       << i
    height_searcher.data_set[user[:height]] << i
    index_searcher.data_set[user[:index]]   << i
    salary_searcher.data_set[user[:salary]] << i

    ppl.push user
  end
end

# Register searchers
search_engine.register_searcher(sex_searcher)
search_engine.register_searcher(age_searcher)
search_engine.register_searcher(height_searcher)
search_engine.register_searcher(index_searcher)
search_engine.register_searcher(salary_searcher)

# NOTE: WHEN YOU WANNA USE RANGE ACTIONS (10 < .. < 20),
# YOU SHOULD SET A RANGE VALUE OF IN VALUE OPTION: action: <>, value: (10..20)
result = nil

searching = Benchmark.measure do
  result =
    search_engine
      .select_by(context: :sex,    action: '=',    value: 0)
      .select_by(context: :age,    action: '<=<=', value: 30..55)
      .select_by(context: :height, action: '>',    value: 1)
      .select_by(context: :index,  action: '<',    value: 900_000)
      .select_by(context: :salary, action: '>',    value: 1)
      .get_result
end

# puts ppl.pretty_inspect
# puts result.pretty_print_inspect

puts "INITIALIZATION: #{initialization}"
puts "SEARCHING: #{searching}"
