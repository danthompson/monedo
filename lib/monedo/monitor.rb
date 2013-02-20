module Monedo

  class Monitor
    attr_reader :queue

    def self.run
      monitor = new($stdin, $stdout)
      monitor.run
    end

    def initialize(input, output)
      @input = input
      @output = output
      @queue = []
    end

    def run
      message = Message.new

      @input.each do |line|

        compose(message, line)

        if message.valid?
          @queue << message.clone
          display(message)
          message.clear
        end

      end
    end

    private

    def display(message)
      @output.puts message.address,
                   message.numeric,
                   message.alpha
    end

    def compose(message, raw)
      line = LineParser.new(raw)

      if line.kind
        message.clear if line.address?
        message[line.kind] = line.data
      end
    end
  end

end
