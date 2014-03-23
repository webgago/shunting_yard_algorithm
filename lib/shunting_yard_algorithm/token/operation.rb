module ShuntingYardAlgorithm
  class Token::Operation < Token
    include Comparable

    REGEXP        = /[\+\-\*\/\^]+/
    PRECEDENCE    = {:+ => 2, :- => 2, :* => 3, :/ => 3, :^ => 4}
    RIGHT_TO_LEFT = [:^]
    OPERATIONS = %w(+ - * / ^)

    def self.match?(string)
      string.in? OPERATIONS
    end

    def initialize(value)
      @value = value.to_sym
    end

    def precedence
      PRECEDENCE[value]
    end

    def <=>(value)
      return unless value.respond_to?(:precedence)
      precedence <=> value.precedence
    end

    def call(left, right)
      left.send method, right
    end

    def method
      if value == :^
        :**
      else
        value
      end
    end

    def right_to_left?
      RIGHT_TO_LEFT.include?(value)
    end

    def valid?
      PRECEDENCE.keys.include? value
    end

    # @param [ShuntingYardAlgorithm::Tokenizer] tokenizer
    def resolve(tokenizer)
      return tokenizer.to_stack(self) if right_to_left?
      return unless valid?

      case self <=> tokenizer.last_operation
      when 0, -1
        tokenizer.to_output tokenizer.pop_stack
        resolve(tokenizer)
      else
        tokenizer.to_stack self
      end
    end
  end
end