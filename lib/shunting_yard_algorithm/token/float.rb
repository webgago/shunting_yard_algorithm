module ShuntingYardAlgorithm
  class Token::Float < Token::Number
    REGEXP = /\d+(\.\d+)?/

    def self.match?(string)
      string.to_d.to_s == string
    end

    def initialize(value)
      @value = value.to_d
    end
  end
end