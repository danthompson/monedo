require 'spec_helper'

module Monedo

  describe Message do

    describe '.from_hash' do
      it 'returns a message constructed from a hash' do
        data = { address: '123', numeric: '1-23', alpha: 'now is the time' }
        message = Message.from_hash(data)

        expect(message.address).to eq(data[:address])
        expect(message.numeric).to eq(data[:numeric])
        expect(message.alpha).to eq(data[:alpha])
      end

      it 'returns nil when missing data' do
        data = { address: '123', numeric: '1-23' }
        message = Message.from_hash(data)

        expect(message).to eq(nil)
      end
    end

    describe '#to_s' do
      it 'returns the message in log like format' do
        iso_time = '1970-01-01T00:00:00Z'
        utc_time = Time.utc(iso_time)
        message = Message.new('123', '1-23', 'hello', utc_time)
        line = "#{iso_time} #123 hello"

        expect(message.to_s).to eq(line)
      end
    end
  end

end
