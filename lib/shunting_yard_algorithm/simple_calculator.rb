module ShuntingYardAlgorithm
  class SimpleCalculator < Calculator
    def resolve_token(token)
      case token
      when /\A\d+\Z/
        @output.push token
      when /\A[\(\)]+\Z/
        resolve_bracket_token(token.to_sym)
      when /\A[\+\-\*\/\^]+\Z/
        resolve_operation_token(token.to_sym)
      end
    end

  private

    def resolve_bracket_token(token)
      if token == :'('
        @stack.unshift token
      else
        until @stack.first == :'('
          @output.push @stack.shift
        end
        @stack.shift
      end
    end

    def resolve_operation_token(token)
      return @stack.unshift(token) if RIGHT_TO_LEFT.include?(token)

      if PRECEDENCE.keys.include? token
        case PRECEDENCE[token] <=> PRECEDENCE[@stack.first]
        when 0
          @output.push @stack.shift
          resolve_operation_token token
        else
          @stack.unshift token
        end
      end
    end
  end
end