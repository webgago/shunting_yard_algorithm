require 'shunting_yard_algorithm/token'
require 'shunting_yard_algorithm/expression'

module ShuntingYardAlgorithm
  class Interpreter
    def initialize(tokens)
      @tokens = tokens.dup
      @tree = []
    end

    def interpret
      while token = @tokens.shift
        @tree.push token

        if operation?(last_token) && operation?(next_token)
          collapse_expression
        else
          if next_token.is_a?(Token::Operation)
            @tree.push @tokens.shift
            collapse_expression
          end
        end
      end

      Expression.new(*@tree)
    end

  private

    def last_token
      @tree.last
    end

    def operation?(token)
      token.is_a?(Token::Operation)
    end

    def next_token
      @tokens.first
    end

    def collapse_expression
      left, right, operation = *@tree.pop(3)
      @tree.push Expression.new(left, right, operation)
    end
  end
end