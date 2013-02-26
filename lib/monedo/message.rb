module Monedo

  Message = Struct.new(:address, :numeric, :alpha) do
    def clear
      initialize
    end

    def valid?
      values.all? && !!alpha.index(/\w\s\w/)
    end

    def to_s
      "address=#{address} numeric=\"#{numeric}\" alpha=\"#{alpha}\""
    end
  end

end
