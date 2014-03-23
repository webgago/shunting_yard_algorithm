require 'thor'
require 'shunting_yard_algorithm'
require 'benchmark'

module ShuntingYardAlgorithm
  class CLI < Thor
    desc "calculate", "an example task"
    def calculate(input)
      result = Calculator.calculate input
      puts "result for \n #{input} \n is #{result}"
    end
  end
end