module ShuntingYardAlgorithm
  class Token::Space < Token
    REGEXP = /\s+/

    # @param [ShuntingYardAlgorithm::Tokenizer] tokenizer
    def resolve(tokenizer)
    end
  end
end