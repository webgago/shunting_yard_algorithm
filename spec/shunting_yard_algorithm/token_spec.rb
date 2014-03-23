require 'spec_helper'

describe Token do

  describe '.create' do
    def create token
      described_class.create(token)
    end

    it 'returns Number for integers' do
      expect(create('1')).to be_a Token::Number
      expect(create('9999999999999999999999999999')).to be_a Token::Number
    end

    it 'returns Number for floats' do
      expect(create('1.0')).to be_a Token::Number
      expect(create('90000.999999999999')).to be_a Token::Number
    end

    %w(( )).each do |bracket|
      it "returns Bracket for '#{bracket}'" do
        expect(create(bracket)).to be_a Token::Bracket
      end
    end

    %w(+ - * / ^).each do |op|
      it "returns Operation for '#{op}'" do
        expect(create(op)).to be_a Token::Operation
      end
    end

    it 'returns Space for " "' do
      expect(create(' ')).to be_a Token::Space
    end
  end

end