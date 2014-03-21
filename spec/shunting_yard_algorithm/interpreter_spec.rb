require 'spec_helper'

describe Interpreter do
  let(:tokens) { create_tokens "1 + 2 * 3" }

  describe '#collapse' do
    def collapse tokens=tokens
      described_class.new(tokens).collapse
    end

    it 'returns an Expression' do
      expect(collapse).to be_an Expression
    end

    it 'creates tree with 2 expressions and 3 numbers' do
      expect(collapse.left).to be_a Token::Number
      expect(collapse.right).to be_an Expression
      expect(collapse.right.left).to be_a Token::Number
    end

    it 'makes expression with right operations' do
      expect(collapse.operation).to be_a Token::Operation
      expect(collapse.operation.value).to be :+

      expect(collapse.right.operation).to be_a Token::Operation
      expect(collapse.right.operation.value).to be :*
    end

    it 'makes expression with right values' do
      expect(collapse.left.value).to be 1
      expect(collapse.right.left.value).to be 2
      expect(collapse.right.right.value).to be 3
    end

    context 'when given bad tokens' do
      it 'raises an ArgumentError' do
        expect { collapse create_tokens "1 + 2 *" }.to raise_error(ArgumentError, "wrong number of arguments (2 for 3)")
        expect { collapse create_tokens "1 + 2 * *" }.to raise_error(ArgumentError, "Right operand must be a Token::Number or Expression, but <*> given")
        expect { collapse create_tokens "1 + 2 * * 1 1 - 1" }.to raise_error(ArgumentError, "Left operand must be a Token::Number or Expression, but <+> given")
      end
    end
  end
end