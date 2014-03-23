require 'shunting_yard_algorithm/token'

module ShuntingYardAlgorithm
  class Expression
    attr_reader :left, :right, :operation

    def initialize(left, right, operation)
      @left, @right, @operation = left, right, operation
      validate_operand! @left, 'Left'
      validate_operand! @right, 'Right'
      validate_operation! @operation
    end

    def inspect
      "(#{@left.inspect}#{@operation.method}#{@right.inspect})"
    end

    def value
      @operation.call @left.value, @right.value
    end

    def validate_operand!(operand, message)
      raise ArgumentError, "#{message} operand must be a Token::Number or Expression, but #{operand.inspect} given" if !operand.is_a?(Token::Number) && !operand.is_a?(Expression)
    end

    def validate_operation!(operation)
      raise ArgumentError, "Operation must be a Token::Operation, but #{operation.inspect} given" unless operation.is_a? Token::Operation
    end
  end
end