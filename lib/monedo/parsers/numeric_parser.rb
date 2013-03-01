module Monedo
  module Parsers

    class NumericParser
      include Parser

      def kind
        :numeric
      end

      def parse(line)
        super
        line[/\s(.*)/i].strip
      end
    end

  end
end
