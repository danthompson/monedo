require 'spec_helper'

describe Monedo::Message do
  describe '#clear' do
    it 'clears the message values' do
      message = Monedo::Message.new('123','1-23','now is the time')
      message.clear
      values = [message.address, message.numeric, message.alpha]

      expect(values.all?).to eq(false)
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

  describe '#to_s' do
    it 'returns the message in log like format' do
      iso_time = '1970-01-01T00:00:00Z'
      utc_time = Time.utc(iso_time)
      message = Monedo::Message.new('123', '1-23', 'hello', utc_time)
      line = %{received_at=#{iso_time} address=123 numeric="1-23" alpha="hello"}

      expect(message.to_s).to eq(line)
    end
  end
end
