module Monedo

  class Message
    attr_accessor :address, :numeric, :alpha

    def initialize(address = nil, numeric = nil, alpha = nil)
      @address = address
      @numeric = numeric
      @alpha = alpha
    end

    def clear
      initialize
    end

    def valid?
      [address, numeric, alpha].all? && !!alpha.index(/\w\s\w/)
    end

    def to_s
      "address=#{address} numeric=\"#{numeric}\" alpha=\"#{alpha}\""
    end
  end

end
