require 'spec_helper'

describe Interpreter do
  let(:tokens) { create_tokens "1 + 2 * 3" }

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
        expect { interpret create_tokens "1 + 2 *" }.to raise_error(ArgumentError, "wrong number of arguments (2 for 3)")
        expect { interpret create_tokens "1 + 2 * *" }.to raise_error(ArgumentError, "Right operand must be a Token::Number or Expression, but <Operation: *> given")
        expect { interpret create_tokens "1 + 2 * * 1 1 - 1" }.to raise_error(ArgumentError, "Left operand must be a Token::Number or Expression, but <Operation: +> given")
      end
    end

    it 'evals big input' do
      pending
      t100 = generate_tokens 100
      t10000 = generate_tokens 10000

      Benchmark.benchmark Benchmark::CAPTION, 20 do |x|
        i100    = x.report('100 operands') { interpret(t100).value }
        i10000  = x.report('10000 operands') { tokenize(t10000).value }

        expect(i10000.real).to be_within(0.15).of i100.real * 100
      end
    end
  end
end