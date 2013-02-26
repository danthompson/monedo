module Monedo

  class LineParser
    def initialize(line)
      @line = line
      @kinds = [:address, :numeric, :alpha]
    end

    def kind
      @kind ||= @kinds.detect do |key|
        @line =~ /#{key.to_s}:/i
      end
    end

    def data
      @data ||= case kind
                when :address then parse_address
                when :numeric then parse_numeric
                when :alpha then parse_alpha
                end
    end

    private

    def parse_address
      parse_data('(\d+)')
    end

    def parse_numeric
      parse_data('(.+)')
    end

    def parse_alpha
      parse_data('(?<=^|>)[^><]+?(?=<|$)')
    end

    def parse_data(pattern)
      data = @line[/(?<=#{kind.to_s}:)(.*)/i][/#{pattern}/i]

      data.strip if data
    end
  end

end
