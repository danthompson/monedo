require 'spec_helper'

describe Monedo::Message do
  describe '#clear' do
    it 'clears the message values' do
      message = Monedo::Message.new('123','1-23','now is the time')
      message.clear

      expect(message.values.all?).to eq(false)
    end
  end

  describe '#valid?' do
    it 'returns true if values are valid' do
      message = Monedo::Message.new('123','1-23','now is the time')

      expect(message.valid?).to eq(true)
    end

    it 'returns false if missing a value' do
      message = Monedo::Message.new(nil, '1-23', 'now is the time')

      expect(message.valid?).to eq(false)
    end

    it 'returns false if a alpha value is malformed' do
      message = Monedo::Message.new('123', '1-23', '999<ESC><RS>H,<VT><FF>1')

      expect(message.valid?).to eq(false)
    end
  end
end