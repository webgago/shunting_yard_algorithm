require 'forwardable'
require 'shunting_yard_algorithm/tokenizer'
require 'shunting_yard_algorithm/interpreter'

module ShuntingYardAlgorithm
  class AbstractCalculator
    extend Forwardable

    PRECEDENCE    = {:+ => 2, :- => 2, :* => 3, :/ => 3, :^ => 4}
    RIGHT_TO_LEFT = [:^]

    def_delegator :@tokenizer, :tokenize

    def initialize(input)
      @input = input
      @tokenizer = Tokenizer.new(@input)
    end

    def calculate
      compile
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