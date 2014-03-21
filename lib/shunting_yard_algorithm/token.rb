module ShuntingYardAlgorithm
  class Token
    attr_reader :value

    def inspect
      "<#@value>"
    end

    class Number < self
      def initialize(value)
        @value = value.to_i
      end

      def resolve(output, stack)
        output.push self
      end
    end

    class Bracket < self
      def initialize(value)
        @value = value
      end

      def opening?
        value == ?(
      end

      def resolve(output, stack)
        if opening?
          stack.unshift self
        else
          until stack.first.respond_to?(:opening?) && stack.first.opening?
            output.push stack.shift
          end
          stack.shift
        end
      end
    end

    class Operation < self
      include Comparable

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

      # @param [Array] stack
      # @param [Array] output
      def resolve(output, stack)
        return stack.unshift(self) if RIGHT_TO_LEFT.include?(value)

        if PRECEDENCE.keys.include? value
          case self <=> stack.first
          when 0, -1
            output.push stack.shift
            self.resolve(output, stack)
          else
            stack.unshift self
          end
        end
      end
    end

    def self.create(token)
      case token
      when /\A\d+\Z/
        Number.new(token)
      when /\A[\(\)]+\Z/
        Bracket.new(token)
      when /\A[\+\-\*\/\^]+\Z/
        Operation.new(token)
      end
    end
  end
end