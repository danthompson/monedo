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
    end

    def run
      buffer = {}

      @input.each do |line|

        add_to_buffer(line, buffer)

        if message = MessageComposer.new(buffer).compose

          display(message)

          buffer.clear
        end
      end

    end

    private

    def add_to_buffer(line, buffer)
      return unless parser = match_parser(line)

      buffer.clear if parser.first_line?
      buffer[parser.kind] = parser.parse(line)
    end

    def match_parser(line)
      @parsers.detect{ |p| p.match?(line) }
    end

    def display(message)
      @output.puts message
    end
  end

end
