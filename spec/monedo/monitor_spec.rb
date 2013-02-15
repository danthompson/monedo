require 'spec_helper'

describe Monedo::Monitor do

  describe '#run' do
    let(:address_part) { "POCSAG1200-: Address:    2222  Function: 0" }
    let(:numeric_part) { "POCSAG1200-: Numeric: 2 22-2[2.2U222  2U22 ]]2UU222U22" }
    let(:alpha_part) { "POCSAG1200-: Alpha: Message for 2222 <EOT>" }
    let(:message) { [ address_part, numeric_part, alpha_part ] }

    it 'adds a message composed of parts to the queue' do
      input = message
      monitor = Monedo::Monitor.new(input, StringIO.new)
      monitor.run

      expect(monitor.queue.length).to eq(1)
    end

    context 'when adding a message to the queue' do
      it 'ignores non-sequential parts' do
        bad_address_part = "POCSAG1200-: Address:    9999  Function: 0"
        bad_alpha_part = "POCSAG1200-: Alpha: 999<ESC><RS>H,<VT><FF><CR>(1s4K<"
        input = [bad_address_part, message, bad_alpha_part].flatten
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
    end
  end

end
