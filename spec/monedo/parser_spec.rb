require 'spec_helper'

module Monedo

  class TestParser
    include Parser

    def kind; :test; end
  end


  describe Parser do
    let(:parser) { TestParser.new }

    describe '#match?' do
      it 'matches a line to a kind' do 
        line = 'head: test: now is the time'

        expect(parser.match?(line)).to eq(true)
     end

      it 'does not match a line of a different kind' do
        line = 'head: nope: now is the time'

        expect(parser.match?(line)).to eq(false)
      end
    end

    describe '#parse' do
      it 'pre parses the line removing the kind' do
        line = 'head: test: now is the time'

        expect(parser.parse(line)).to eq(' now is the time')
      end
    end

    describe '#first_line?' do
      it 'returns false by default' do
        expect(parser.first_line?).to eq(false)
      end
    end
  end

end
