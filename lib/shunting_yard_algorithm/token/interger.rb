module ShuntingYardAlgorithm
  class Token::Integer < Token::Number
    REGEXP = /\d+/

    def self.match?(string)
      string.to_i.to_s == string
    end

    def initialize(value)
      @value = value.to_i
    end
  end
end