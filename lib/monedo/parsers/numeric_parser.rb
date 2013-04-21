module Monedo
  module Parsers
    class NumericParser
      include Parser

      def kind
        :numeric
      end

      def parse(line)
        super
        line[/\s(.*)/i].to_s.strip
      end
    end
  end
end
