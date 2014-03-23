module ShuntingYardAlgorithm
  class Token
    attr_reader :value

    class << self
      def regexp
        self::REGEXP
      end

      def match?(string)
        string =~ /\A#{regexp}\Z/
      end

      def types
        @types ||= []
      end

      def inherited(subclass)
        types << subclass
      end
    end

    def initialize(value)
      @value = value
    end

    def inspect
      "<#{self.class.name.demodulize}: #@value>"
    end

    def self.create(token)
      if type = types.detect { |type| type.match?(token) }
        type.new(token)
      end
    end
  end
end