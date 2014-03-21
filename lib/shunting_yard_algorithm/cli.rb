require 'thor'
require 'shunting_yard_algorithm'
require 'benchmark'

module ShuntingYardAlgorithm
  class CLI < Thor
    desc "calculate", "an example task"
    def calculate(input)
      puts Calculator.calculate input
    end
  end
end