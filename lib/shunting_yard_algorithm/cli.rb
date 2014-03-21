require 'thor'
require 'shunting_yard_algorithm'
require 'benchmark'

module ShuntingYardAlgorithm
  class CLI < Thor
    desc "calculate", "an example task"
    method_option :eval, aliases: "-e", default: false, desc: "Compile input with Ruby parser (eval)"
    def calculate(input)
      oop = OOPCalculator.new(input)

      puts oop.calculate options[:eval]
    end
  end
end