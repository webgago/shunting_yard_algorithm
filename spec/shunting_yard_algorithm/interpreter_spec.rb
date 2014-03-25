require 'spec_helper'

describe Interpreter do
  let(:tokens) { create_tokens "1 + 2 * 3" }

  describe '#initialize' do
    it 'accept array of tokens as "tokens" parameter' do
      expect { described_class.new(tokens).interpret }.to_not raise_error
    end

    it 'accept tokenizer as "tokens" parameter' do
      expect { described_class.new(tokens).interpret }.to_not raise_error
    end
  end

  describe '#interpret' do
    def interpret tokens=tokens
      described_class.new(tokens).interpret
    end

    it 'returns an Expression' do
      expect(interpret).to be_an Expression
    end

    it 'creates tree with 2 expressions and 3 numbers' do
      expect(interpret.left).to be_a Token::Number
      expect(interpret.right).to be_an Expression
      expect(interpret.right.left).to be_a Token::Number
    end

    it 'makes expression with right operations' do
      expect(interpret.operation).to be_a Token::Operation
      expect(interpret.operation.value).to be :+

      expect(interpret.right.operation).to be_a Token::Operation
      expect(interpret.right.operation.value).to be :*
    end

    it 'makes expression with right values' do
      expect(interpret.left.value).to be 1
      expect(interpret.right.left.value).to be 2
      expect(interpret.right.right.value).to be 3
    end

    context 'when given bad tokens' do
      it 'raises an ArgumentError' do
        expect { interpret create_tokens "1 + 2 *" }.to raise_error(ArgumentError, "Right operand must be a Token::Number or Expression, but <Plus: +> given")
        expect { interpret create_tokens "1 + 2 * *" }.to raise_error(ArgumentError, "Right operand must be a Token::Number or Expression, but <Multiply: *> given")
        expect { interpret create_tokens "1 + 2 * * 1 1 - 1" }.to raise_error(ArgumentError, "Left operand must be a Token::Number or Expression, but <Plus: +> given")
        expect { interpret create_tokens "1 / 0 * * 1 1 - 1" }.to raise_error(ZeroDivisionError, "divided by 0")
      end
    end

    it 'evals big input' do
      tokens = nil
      puts Benchmark.realtime { tokens = generate_tokens(1000) }
      puts Benchmark.realtime { interpret(tokens).value }
    end
  end
end