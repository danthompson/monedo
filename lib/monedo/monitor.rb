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
      message = {}

      @input.each do |line|

        case
        when !!(line =~ /Address:/)
          message.clear
          message.merge!(address: line)
        when !!(line =~ /Numeric:/)
          message.merge!(numeric: line)
        when !!(line =~ /Alpha:/)
          message.merge!(alpha: line)
        end

        if [:address, :numeric, :alpha].all? { |k| message.key?(k) }
          @queue << message
          @output.puts message[:address],
                       message[:numeric],
                       message[:alpha]
          message.clear
        end

      end
    end
  end

end
