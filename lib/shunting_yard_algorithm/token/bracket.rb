module ShuntingYardAlgorithm
  class Token::Bracket < Token
    REGEXP = /[\(\)]+/

    def self.match?(string)
      string == ?( || string == ?)
    end

    def opening?
      value == ?(
    end

    # @param [ShuntingYardAlgorithm::Tokenizer] tokenizer
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
end