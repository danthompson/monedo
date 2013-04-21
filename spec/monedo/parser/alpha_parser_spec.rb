require 'spec_helper'

module Monedo
  module Parsers

    describe AlphaParser do
      subject { AlphaParser.new }

      describe '#kind' do
        it 'returns kind as alpha' do
          expect(subject.kind).to eq(:alpha)
        end
      end

      describe '#parse' do
        it 'returns the alpha from the line' do
          alpha = 'Message» for 2222'
          alpha_line = "POCSAG1200-: Alpha: #{alpha} <EOT><NUL>"

          expect(subject.parse(alpha_line)).to eq(alpha)
        end
      end

      describe '#first_line?' do
        it 'returns false for a alpha line' do
          expect(subject.first_line?).to eq(false)
        end
      end
    end

  end
end
