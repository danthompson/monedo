require 'spec_helper'

module Monedo
  module Parsers

    describe AddressParser do
      let(:parser) { AddressParser.new }

      describe '#kind' do
        it 'returns kind as address' do
          expect(parser.kind).to eq(:address)
        end
      end

      describe '#parse' do
        it 'returns the address from the line' do
          address = '2222'
          address_line = "POCSAG1200-: Address:    #{address}  Function: 0"

          expect(parser.parse(address_line)).to eq(address)
        end
      end

      describe '#first_line?' do
        it 'returns true for an address line' do
          expect(parser.first_line?).to eq(true)
        end
      end
    end

  end
end
