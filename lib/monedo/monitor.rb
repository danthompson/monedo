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

    def display(message)
      @output.puts message.address,
                   message.numeric,
                   message.alpha
    end

    def compose(message, line)
      case
      when !!(line =~ /Address:/)
        message.clear
        message.address = pluck_address_data(line)
      when !!(line =~ /Numeric:/)
        message.numeric = pluck_numeric_data(line)
      when !!(line =~ /Alpha:/)
        message.alpha = pluck_alpha_data(line)
      end
    end

    def pluck_address_data(line)
      pluck_data(:address, '(\d+)', line)
    end

    def pluck_numeric_data(line)
      pluck_data(:numeric, '(.+)', line)
    end

    def pluck_alpha_data(line)
      pluck_data(:alpha, '(?<=^|>)[^><]+?(?=<|$)', line)
    end

    def pluck_data(key, pattern, line)
      data = line[/(?<=#{key.to_s}:)(.*)/i][/#{pattern}/i]

      data.strip if data
    end
  end

end
