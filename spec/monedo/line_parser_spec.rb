# encoding: utf-8

require 'spec_helper'

describe Monedo::LineParser do
  let(:address) { '2222' }
  let(:numeric) { '2 22-2[2.2U222  2U22 ]]2UU222U22' }
  let(:alpha) { 'Message» for 2222' }
  let(:address_line) { "POCSAG1200-: Address:    #{address}  Function: 0" }
  let(:numeric_line) { "POCSAG1200-: Numeric: #{numeric}" }
  let(:alpha_line) { "POCSAG1200-: Alpha: #{alpha} <EOT><NUL>" }
  let(:unkown_line) { "POCSAG1200-: Unkown: Now is the time" }

  describe '#kind' do
    it 'returns a kind when detected' do
      line = Monedo::LineParser.new(alpha_line)
      expect(line.kind).to eq(:alpha)
    end

    it 'returns nil when no kind is detected' do
      line = Monedo::LineParser.new(unkown_line)
      expect(line.kind).to eq(nil)
    end
  end

  describe '#data' do
    it 'returns the address data if kind is address' do
      line = Monedo::LineParser.new(address_line)
      expect(line.data).to eq(address)
    end

    it 'returns the numeric data if kind is numeric' do
      line = Monedo::LineParser.new(numeric_line)
      expect(line.data).to eq(numeric)
    end

    it 'returns the alpha data if kind is alpha' do
      line = Monedo::LineParser.new(alpha_line)
      expect(line.data).to eq(alpha)
    end

    it 'returns nil if kind does not match' do
      line = Monedo::LineParser.new(unkown_line)
      expect(line.data).to eq(nil)
    end
  end

  describe '#address?' do
    it 'returns true if kind is address' do
      line = Monedo::LineParser.new(address_line)
      expect(line.kind).to eq(:address)
    end

    it 'returns false if kind is not address' do
      line = Monedo::LineParser.new(numeric_line)
      expect(line.kind).to_not eq(:address)
    end
  end
end
