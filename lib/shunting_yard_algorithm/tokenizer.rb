require 'shunting_yard_algorithm/token'
require 'shunting_yard_algorithm/expression'

module ShuntingYardAlgorithm
  class Tokenizer
    class Scanner < StringScanner
      def token_regexp
        @regexp ||= Regexp.union(Token::Number::REGEXP, Token::Operation::REGEXP, Token::Bracket::REGEXP, /\s+/)
      end

      def next_token
        scan token_regexp
      end
    end

    def initialize(input)
      @output = []
      @stack  = []
      @input = Scanner.new(input)
    end

    def tokenize
      while token = @input.next_token
        resolve_token(token)
      end
      @output.concat @stack
    end

    def resolve_token(chars)
      if token = Token.create(chars)
        token.resolve(self)
      end
    end

    def to_output(token)
      @output.push token
    end

    def to_stack(token)
      @stack.unshift token
    end

    def last_operation
      @stack.first
    end

    def pop_stack
      @stack.shift
    end
  end
end