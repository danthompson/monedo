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

        compose(message, line)

        if composed?(message)
          @queue << message.clone
          display(message)
          message.clear
        end

      end
    end

    def display(message)
      @output.puts message[:address],
                   message[:numeric],
                   message[:alpha]
    end

    def compose(message, line)
      case
      when !!(line =~ /Address:/)
        message.clear
        message.merge! pluck_address_data(line)
      when !!(line =~ /Numeric:/)
        message.merge! pluck_numeric_data(line)
      when !!(line =~ /Alpha:/)
        message.merge! pluck_alpha_data(line)
      end
    end

    def composed?(message)
      [:address, :numeric, :alpha].all? { |k| message.key?(k) }
    end

    def pluck_address_data(line)
      pluck_data(:address, '(?<=address:\s\s\s\s)(\d+)', line)
    end

    def pluck_numeric_data(line)
      pluck_data(:numeric, '(?<=numeric:\s)(.+)', line)
    end

    def pluck_alpha_data(line)
      pluck_data(:alpha, '(?<=alpha:\s)(.+)', line)
    end

    def pluck_data(key, pattern, line)
      data = line[/#{pattern}/i]

      (data.nil? || data.strip.empty?) ? {} : { key => data.strip }
    end
  end

end
