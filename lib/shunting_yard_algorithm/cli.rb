require 'thor'
require 'shunting_yard_algorithm'
require 'benchmark'

module ShuntingYardAlgorithm
  class CLI < Thor
    desc "calculate", "an example task"
    def calculate(input)
      if File.exist? input
        input = File.read input
      end
      calc = Calculator.new(input)
      result = calc.calculate
      puts "result for \n #{input} \n is #{result}"
      puts "calculation took a #{calc.times.inspect}"
      puts "calculated #{calc.operands_count} numbers"
    end
  end
end