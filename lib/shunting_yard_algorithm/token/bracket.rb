module ShuntingYardAlgorithm
  class Token::Bracket < Token
    REGEXP = /[\(\)]+/

    def opening?
      value == ?(
    end

    # @param [ShuntingYardAlgorithm::Calculator] tokenizer
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