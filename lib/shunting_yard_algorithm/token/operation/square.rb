module ShuntingYardAlgorithm
  class Token::Operation::Square < Token::Operation
    def self.match?(string)
      string == ?^
    end

    def precedence
      4
    end

    def right_to_left?
      true
    end

    def call(left, right)
      left ** right
    end
  end
end