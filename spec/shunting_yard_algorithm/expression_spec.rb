require 'spec_helper'

describe Expression do
  let(:left_operand) { create_token('2') }
  let(:right_operand) { create_token('2') }
  let(:operator) { create_token('+') }

  subject { described_class.new left_operand, right_operand, operator }

  describe '#value' do
    context 'when operands are Tokens' do
      it 'evals an expression' do
        expect(subject.value).to eql 4
      end
    end

    context 'when left operand is a Expression' do
      let(:left_operand) { create_expression('1', '1', '+') }

      it 'evals an expression' do
        expect(subject.value).to eql 4
      end
    end

    context 'when right operand is a Expression' do
      let(:right_operand) { create_expression('1', '1', '+') }

      it 'evals an expression' do
        expect(subject.value).to eql 4
      end
    end

    context 'when both operands are Expressions' do
      let(:left_operand) { create_expression('1', '1', '+') }
      let(:right_operand) { create_expression('1', '1', '+') }

      subject { described_class.new create_expression('1', '1', '+'), create_expression('1', '1', '+'), create_token('*') }

      it 'evals an expression' do
        expect(subject.value).to eql 4
      end
    end
  end
end