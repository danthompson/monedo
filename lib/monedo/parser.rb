module Monedo

  module Parser

    def match?(line)
     !!(/(?<=#{kind.to_s}:)/i =~ line)
    end

    def parse(line)
      line.gsub!(/.*(?<=#{kind.to_s}:)/i, '')
    end

    def first_line?
      false
    end
  end

end
