module ShuntingYardAlgorithm
  class Token
    attr_reader :value

    def inspect
      "<#@value>"
    end

    class Number < self
      REGEXP = /\d+/

      def initialize(value)
        @value = value.to_i
      end

      # @param [ShuntingYardAlgorithm::Calculator] tokenizer
      def resolve(tokenizer)
        tokenizer.to_output self
      end
    end

    class Bracket < self
      REGEXP = /[\(\)]+/

      def initialize(value)
        @value = value
      end

      def opening?
        value == ?(
      end

      # @param [ShuntingYardAlgorithm::Calculator] tokenizer
      def resolve(tokenizer)
        if opening?
          tokenizer.to_stack self
        else
          until tokenizer.last_operation.respond_to?(:opening?) && tokenizer.last_operation.opening?
            tokenizer.to_output tokenizer.pop_stack
          end
          tokenizer.pop_stack
        end
      end
    end

    class Operation < self
      include Comparable

      REGEXP = /[\+\-\*\/\^]+/
      PRECEDENCE    = {:+ => 2, :- => 2, :* => 3, :/ => 3, :^ => 4}
      RIGHT_TO_LEFT = [:^]

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

      # @param [ShuntingYardAlgorithm::Calculator] tokenizer
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

    def self.create(token)
      case token
      when /\A#{Number::REGEXP}\Z/
        Number.new(token)
      when /\A#{Bracket::REGEXP}\Z/
        Bracket.new(token)
      when /\A#{Operation::REGEXP}\Z/
        Operation.new(token)
      end
    end
  end
end