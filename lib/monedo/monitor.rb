module Monedo
  class Monitor
    def self.run
      monitor = new
      monitor.run
    end

    def initialize(input = $stdin, output = $stdout)
      @input = input
      @logger = Logger.new(output)
      @logger.formatter = proc { |*, message| "#{message}\n" }
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

    attr_reader :buffer, :logger

    def buffer_data(line)
      return unless parser = @parsers.detect{ |p| p.match?(line) }

      buffer.clear if parser.first_line?
      buffer.store(parser.kind, parser.parse(line))
    end

    def process_buffer
      Message.from_hash(buffer) do |message|

        logger.info message

        buffer.clear
      end
    end
  end
end
