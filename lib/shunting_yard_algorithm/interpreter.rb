require 'shunting_yard_algorithm/token'
require 'shunting_yard_algorithm/expression'

module ShuntingYardAlgorithm
  class Interpreter
    # @param [ShuntingYardAlgorithm::Tokenizer] tokens
    def initialize(tokens)
      @tokens = tokens.dup
      @tree = []
    end

    def interpret
      raise ArgumentError, 'tokens are empty' if @tokens.empty?

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

      case @tree.count
      when 3
        Expression.new(*@tree)
      when 1
        @tree.first
      else
        collapse_tree
      end
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

    def collapse_tree
      @tokens = @tree.dup
      @tree.clear
      interpret
    end

    def collapse_expression
      left, right, operation = *@tree.pop(3)
      @tree.push Expression.new(left, right, operation)
    end
  end
end