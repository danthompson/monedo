module Monedo
  module Parsers
    class AlphaParser
      include Parser

      def kind
        :alpha
      end

      def parse(line)
        super
        data = line[/(?<=^|>)[^><]+?(?=<|$)/].to_s.strip
        data unless corrupt?(data)
      end

      private

      def corrupt?(data)
        !data.index(/\w\s\w/)
      end
    end
  end
end
