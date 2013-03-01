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

        if composable?(buffer)

          message = compose_message(buffer)

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

    def composable?(buffer)
      parser_kinds.all? { |k| buffer.key?(k) && !buffer[k].nil? }
    end

    def parser_kinds
      @parser_kinds ||= @parsers.map(&:kind)
    end

    def compose_message(data)
      Message.new(data[:address], data[:numeric], data[:alpha])
    end

    def display(message)
      @output.puts message
    end
  end

end
