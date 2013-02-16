require 'spec_helper'

describe Monedo::Monitor do

  describe '#run' do
    let(:address) { '2222' }
    let(:numeric) { '2 22-2[2.2U222  2U22 ]]2UU222U22' }
    let(:alpha) { 'Message for 2222 <EOT>' }
    let(:address_part) { "POCSAG1200-: Address:    #{address}  Function: 0" }
    let(:numeric_part) { "POCSAG1200-: Numeric: #{numeric}" }
    let(:alpha_part) { "POCSAG1200-: Alpha: #{alpha}" }
    let(:message_parts) { [ address_part, numeric_part, alpha_part ] }

    it 'adds a message composed of parts to the queue' do
      input = message_parts
      monitor = Monedo::Monitor.new(input, StringIO.new)
      monitor.run

      expect(monitor.queue.length).to eq(1)
    end

    context 'when adding a message to the queue' do
      it 'ignores non-sequential parts' do
        bad_address_part = "POCSAG1200-: Address:    9999  Function: 0"
        bad_alpha_part = "POCSAG1200-: Alpha: 999<ESC><RS>H,<VT><FF><CR>(1s4K<"
        input = [bad_address_part, message_parts, bad_alpha_part].flatten
        monitor = Monedo::Monitor.new(input, StringIO.new)
        monitor.run

        expect(monitor.queue.length).to eq(1)
      end

      it 'ignores incomplete parts' do
        input = [address_part, numeric_part].flatten
        monitor = Monedo::Monitor.new(input, StringIO.new)
        monitor.run

        expect(monitor.queue.length).to eq(0)
      end

      it 'extracts essential information from the parts' do
        input = message_parts
        monitor = Monedo::Monitor.new(input, StringIO.new)
        monitor.run

        message = monitor.queue.first
        expect(message[:address]).to eq(address)
        expect(message[:numeric]).to eq(numeric)
        expect(message[:alpha]).to eq(alpha)
      end
    end
  end

end
