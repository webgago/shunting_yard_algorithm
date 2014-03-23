require 'spec_helper'
require 'benchmark'

describe Tokenizer do
  subject { described_class.new(generate_input) }

  describe '#tokenize' do
    def tokenize input=generate_input
      described_class.new(input).tokenize
    end

    it 'returns an Array of Tokens' do
      expect(tokenize).to be_an Array
      expect(tokenize).to have(5).tokens
      tokenize.each do |token|
        expect(token).to be_a Token
      end
    end

    it 'parses big numbers' do
      expect { tokenize "10000000 * 999999999999999999999999999 ^ 2" }.to_not raise_error
      expect(tokenize "10000000 * 999999999999999999999999999 ^ 2").to have(5).tokens
    end

    it 'parses big input' do
      pending
      Benchmark.benchmark Benchmark::CAPTION, 20 do |x|
        t100    = x.report('100 operands') { tokenize generate_input 100 }
        t10000  = x.report('10000 operands') { tokenize generate_input 10000 }

        expect(t10000.real).to be_within(0.15).of t100.real * 100
      end
    end

    it 'returns the same data for each time' do
      expect(subject.tokenize).to eql subject.tokenize
    end
  end
end