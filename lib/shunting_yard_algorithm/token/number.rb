module ShuntingYardAlgorithm
  class Token::Number < Token
    REGEXP = /\d+(\.\d+)?/

    def self.create(token)
      if type = types.detect { |type| type.match?(token) }
        type.new(token)
      else
        super
      end
    end

    def self.match?(string)
      types.any? { |type| type.match? string }
    end

    # @param [ShuntingYardAlgorithm::Tokenizer] tokenizer
    def resolve(tokenizer)
      tokenizer.to_output self
    end
  end
end