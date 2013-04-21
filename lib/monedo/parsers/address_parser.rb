module Monedo
  module Parsers
    class AddressParser
      include Parser

      def kind
        :address
      end

      def parse(line)
        super
        line[/\s\s\s\s(\d+)/i].to_s.strip
      end

      def first_line?
        true
      end
    end
  end
end
