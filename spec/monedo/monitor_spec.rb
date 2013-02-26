require 'spec_helper'

describe Monedo::Monitor do

  describe '#run' do
    let(:address) { '2222' }
    let(:numeric) { '2 22-2[2.2U222  2U22 ]]2UU222U22' }
    let(:alpha) { 'Message for 2222' }
    let(:address_part) { "POCSAG1200-: Address:    #{address}  Function: 0" }
    let(:numeric_part) { "POCSAG1200-: Numeric: #{numeric}" }
    let(:alpha_part) { "POCSAG1200-: Alpha: #{alpha} <EOT><NUL>" }
    let(:bad_alpha_part) { "POCSAG1200-: Alpha: 999<ESC><RS>H,<VT><FF><CR>(1" }
    let(:message_parts) { [ address_part, numeric_part, alpha_part ] }
    let(:output) { StringIO.new }
    let(:output_lines) { output.rewind; output.readlines.map(&:chomp) }

    it 'displays information from parts collected' do
      input = message_parts
      monitor = Monedo::Monitor.new(input, output)
      monitor.run

      expect([address, numeric, alpha]).to eq(output_lines)
    end

    it 'ignores non-sequential parts' do
      bad_address_part = "POCSAG1200-: Address:    9999  Function: 0"
      input = [bad_address_part, message_parts, bad_alpha_part].flatten
      monitor = Monedo::Monitor.new(input, output)
      monitor.run

      expect([address, numeric, alpha]).to eq(output_lines)
    end

    it 'ignores incomplete parts' do
      input = [address_part, numeric_part]
      monitor = Monedo::Monitor.new(input, output)
      monitor.run

      expect(output_lines.length).to eq(0)
    end

    it 'ignores messages with malformed alpha parts' do
      input = [address_part, numeric_part, bad_alpha_part]
      monitor = Monedo::Monitor.new(input, output)
      monitor.run

      expect(output_lines.length).to eq(0)
    end

  end

end
