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
      @expression = compile
      @expression.value
    end

    def operands_count
      @tokens.count { |t| t.is_a? Token::Number }
    end

    def times
      {tokenize: "#{@time_for_tokenize}ms",
       interpret: "#{@time_for_interpret}ms"}
    end

    def compile
      @time_for_tokenize = Time.now
      @tokens = tokenize
      @time_for_tokenize = Time.now - @time_for_tokenize

      @time_for_interpret = Time.now
      result = Interpreter.new(@tokens).interpret
      @time_for_interpret = Time.now - @time_for_interpret
      result
    end

    def interpret
      raise NotImplementedError
    end
  end
end