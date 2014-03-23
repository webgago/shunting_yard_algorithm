module ShuntingYardAlgorithm
  class Token::Number < Token
    REGEXP = /\d+(\.\d+)?/

    def self.match?(string)
      string =~ /\A#{REGEXP}\Z/
    end

    def initialize(value)
      @value = value.to_i
    end

    # @param [ShuntingYardAlgorithm::Calculator] tokenizer
    def resolve(tokenizer)
      tokenizer.to_output self
    end
  end
end