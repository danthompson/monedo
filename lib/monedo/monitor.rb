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

      case line.kind
      when :address
        message.clear
        message.address = line.data
      when :numeric
        message.numeric = line.data
      when :alpha
        message.alpha = line.data
      end
    end
  end

end
