# encoding: utf-8

module Monedo
  class Monitor
    def self.run
      monitor = new($stdin, $stdout)
      monitor.run
    end

    def initialize(input, output)
      @input = input
      @output = output
      @parsers = [ Parsers::AddressParser.new,
                   Parsers::NumericParser.new,
                   Parsers::AlphaParser.new ]
      @buffer = {}
    end

    def run
      @input.each do |line|

        buffer_data(line)
        process_buffer
      end
    end

    private

    attr_accessor :buffer

    def buffer_data(line)
      return unless parser = @parsers.detect{ |p| p.match?(line) }

      buffer.clear if parser.first_line?
      buffer.store(parser.kind, parser.parse(line))
    end

    def process_buffer
      Message.from_hash(buffer) do |message|

        display(message)

        buffer.clear
      end
    end

    def display(message)
      @output.puts message
    end
  end
end
