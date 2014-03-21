require 'shunting_yard_algorithm/abstract_calculator'
require 'shunting_yard_algorithm/token'
require 'shunting_yard_algorithm/expression'

module ShuntingYardAlgorithm
  class Calculator < AbstractCalculator
    def self.calculate(input)
      new(input).calculate
    end
  end
end