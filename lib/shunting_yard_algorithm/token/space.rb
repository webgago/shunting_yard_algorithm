module ShuntingYardAlgorithm
  class Token::Space < Token
    REGEXP = /[[:space:]]+/

    def self.match?(string)
      string.blank?
    end

    # @param [ShuntingYardAlgorithm::Tokenizer] tokenizer
    def resolve(tokenizer)
    end
  end
end