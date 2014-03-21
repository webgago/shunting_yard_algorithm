require 'shunting_yard_algorithm/token'
require 'shunting_yard_algorithm/expression'

module ShuntingYardAlgorithm
  class OOPCalculator < Calculator
    def resolve_token(token)
      if token = Token.create(token)
        token.resolve(@output, @stack)
      end
    end

    def interpret(tokens=@output)
      Expression.new(*collapsed(tokens)).value
    end

    def collapsed(tokens)
      tree = []
      while token = tokens.shift
        tree.push token
        if tree.last.is_a?(Token::Operation) && tokens.first.is_a?(Token::Operation)
          tree.push Expression.new(*tree.pop(3))
        elsif tokens.first.is_a?(Token::Operation)
          tree.push Expression.new(*tree.pop(2), tokens.shift)
        end
      end
      tree
    end
  end
end