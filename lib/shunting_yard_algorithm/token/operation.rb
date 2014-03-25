module ShuntingYardAlgorithm
  class Token::Operation < Token
    include Comparable
    REGEXP        = /[\+\-\*\/\^]+/

    def self.create(token)
      if type = types.detect { |type| type.match?(token) }
        type.new(token)
      else
        super
      end
    end

    def self.match?(string)
      types.any? { |type| type.match?(string) }
    end

    def initialize(value)
      @value = value.to_sym
    end

    def precedence
      raise NotImplementedError
    end

    def right_to_left?
      raise NotImplementedError
    end

    def call(left, right)
      raise NotImplementedError
    end

    def <=>(value)
      return unless value.respond_to?(:precedence)
      precedence <=> value.precedence
    end

    # @param [ShuntingYardAlgorithm::Tokenizer] tokenizer
    def resolve(tokenizer)
      return tokenizer.to_stack(self) if right_to_left?

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