require 'forwardable'
require 'shunting_yard_algorithm/tokenizer'
require 'shunting_yard_algorithm/interpreter'

module ShuntingYardAlgorithm
  class AbstractCalculator
    extend Forwardable

    def_delegator :@tokenizer, :tokenize

    def initialize(input)
      @input = input
      @tokenizer = Tokenizer.new(@input)
    end

    def calculate
      compile.value
    end

    def compile
      @tokens = tokenize
      Interpreter.new(@tokens).interpret
    end

    def interpret
      raise NotImplementedError
    end
  end
end