require 'spec_helper'

module Monedo

  describe MessageComposer do
    describe '#compose' do
      it 'returns a message composed from data' do
        data = { address: '123', numeric: '1-23', alpha: 'now is the time' }
        message = MessageComposer.new(data).compose

        expect(message.address).to eq(data[:address])
        expect(message.numeric).to eq(data[:numeric])
        expect(message.alpha).to eq(data[:alpha])
      end

      it 'returns nil when missing data' do
        data = { address: '123', numeric: '1-23' }
        message = MessageComposer.new(data).compose

        expect(message).to eq(nil)
      end
    end
  end

end
