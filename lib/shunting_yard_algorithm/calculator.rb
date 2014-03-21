module ShuntingYardAlgorithm
  class Calculator
    PRECEDENCE    = {:+ => 2, :- => 2, :* => 3, :/ => 3, :^ => 4}
    RIGHT_TO_LEFT = [:^]

    def initialize(input)
      @input = input
    end

    def calculate(eval=false)
      if eval
        puts "Evaled: #{eval(@input.gsub('^', '**'))}"
      end
      compile
    end

    def compile
      @output = []
      @stack  = []
      tokenize
      interpret
    end

    def tokenize
      @input.each_char { |token| resolve_token(token) }
      @output.concat @stack
    end

    def resolve_token(token)
      raise NotImplementedError
    end

    def interpret
      @output.join ' '
    end
  end
end