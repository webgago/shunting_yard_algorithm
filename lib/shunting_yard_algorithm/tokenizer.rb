require 'shunting_yard_algorithm/token'
require 'shunting_yard_algorithm/token/bracket'
require 'shunting_yard_algorithm/token/number'
require 'shunting_yard_algorithm/token/operation'
require 'shunting_yard_algorithm/token/space'

require 'shunting_yard_algorithm/token/operation/plus'

require 'shunting_yard_algorithm/expression'

require 'forwardable'

module ShuntingYardAlgorithm
  class Tokenizer
    class Scanner < StringScanner
      def token_regexp
        @regexp ||= Regexp.union(*Token.types.map { |type| type.regexp })
      end

      def next_token
        scan token_regexp
      end
    end

    extend Forwardable

    def_delegator :tokens, :each

    def initialize(input)
      @output = []
      @stack  = []
      @input = input
      @scanner = Scanner.new(@input)
    end

    def tokenize
      clear
      while token = @scanner.next_token
        resolve_token(token)
      end
      @output.concat @stack
    end

    def clear
      @stack.clear
      @output.clear
      @scanner.reset
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