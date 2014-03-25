module ShuntingYardAlgorithm
  class Token
    attr_reader :value

    class << self
      def regexp
        self::REGEXP
      end

      def match?(string)
        @_cached_match_regexp ||= /\A#{regexp}\Z/
        string =~ @_cached_match_regexp
      end

      def types
        @types ||= []
      end

      def inherited(subclass)
        types << subclass
      end
    end

    def initialize(value)
      raise 'Token is an abstract class' if self.class == Token
      @value = value
    end

    def inspect
      "<#{self.class.name.demodulize}: #@value>"
    end

    # @param [ShuntingYardAlgorithm::Tokenizer] tokenizer
    def resolve(tokenizer)
      raise NotImplementedError
    end

    def self.create(token)
      if type = types.detect { |type| type.match?(token) }
        method = type.respond_to?(:create) ? :create : :new
        type.send method, token
      else
        new(token)
      end
    end
  end
end