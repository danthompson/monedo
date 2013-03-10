require 'spec_helper'

module Monedo

  describe Monitor do
    describe '#run' do
      let(:address) { '2222' }
      let(:numeric) { '2 22-2[2.2U222  2U22 ]]2UU222U22' }
      let(:alpha) { 'Message for 2222' }
      let(:address_part) { "POCSAG1200-: Address:    #{address}  Function: 0" }
      let(:numeric_part) { "POCSAG1200-: Numeric: #{numeric}" }
      let(:alpha_part) { "POCSAG1200-: Alpha: #{alpha} <EOT><NUL>" }
      let(:message_parts) { [ address_part, numeric_part, alpha_part ] }
      let(:message_line) { "#{Message.new(address, numeric, alpha)}\n" }
      let(:output) { StringIO.new }

      it 'displays information from parts collected' do
        input = message_parts
        monitor = Monitor.new(input, output)
        monitor.run
        output.rewind

        expect(output.read).to eq(message_line)
      end

      it 'ignores non-sequential parts' do
        bad_address_part = "POCSAG1200-: Address:    9999  Function: 0"
        bad_alpha_part = "POCSAG1200-: Alpha: non sequential alpha part"
        input = [bad_address_part, message_parts, bad_alpha_part].flatten
        monitor = Monitor.new(input, output)
        monitor.run
        output.rewind

        expect(output.read).to eq(message_line)
      end

      it 'ignores incomplete parts' do
        input = [address_part, numeric_part]
        monitor = Monitor.new(input, output)
        monitor.run
        output.rewind

        expect(output.read.length).to eq(0)
      end

      it 'ignores messages with malformed alpha parts' do
        malformed_alpha_part = "POCSAG1200-: Alpha: 999<ESC><RS>H,<VT><CR>(1"
        input = [address_part, numeric_part, malformed_alpha_part]
        monitor = Monitor.new(input, output)
        monitor.run
        output.rewind

        expect(output.read.length).to eq(0)
      end
    end
  end

end
