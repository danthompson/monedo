require 'spec_helper'

describe Monedo::Message do
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
