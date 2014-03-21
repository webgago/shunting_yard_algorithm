module ShuntingYardAlgorithm
  class Expression
    def initialize(left, right, operation)
      @left, @right, @operation = left, right, operation
    end

    def inspect
      "(#{@left.inspect}#{@operation.method}#{@right.inspect})"
    end

    def value
      @operation.call @left.value, @right.value
    end
  end
end