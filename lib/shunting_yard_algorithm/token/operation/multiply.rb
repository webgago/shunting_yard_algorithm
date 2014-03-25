module ShuntingYardAlgorithm
  class Token::Operation::Multiply < Token::Operation
    def self.match?(string)
      string == ?*
    end

    def precedence
      3
    end

    def right_to_left?
      false
    end

    def call(left, right)
      left * right
    end
  end
end