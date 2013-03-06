require 'spec_helper'

module Monedo
  module Parsers

    describe NumericParser do
      subject { NumericParser.new }

      describe '#kind' do
        it 'returns kind as numeric' do
          expect(subject.kind).to eq(:numeric)
        end
      end

      describe '#parse' do
        it 'returns the numeric from the line' do
          numeric = '2 22-2[2.2U222  2U22 ]]2UU222U22'
          numeric_line = "POCSAG1200-: Numeric: #{numeric}"

          expect(subject.parse(numeric_line)).to eq(numeric)
        end
      end

      describe '#first_line?' do
        it 'returns false for a numeric line' do
          expect(subject.first_line?).to eq(false)
        end
      end
    end

  end
end
