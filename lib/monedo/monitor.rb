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
    end

    def run
      message = Message.new

      @input.each do |line|

        compose(message, line)

        if message.valid?
          display(message)
          message.clear
        end

      end
    end

    private

    def display(message)
      @output.puts message
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
