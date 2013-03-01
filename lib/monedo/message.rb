module Monedo

  class Message
    attr_accessor :address, :numeric, :alpha, :received_at

    def initialize(address = nil, numeric = nil, alpha = nil, received_at = Time.now.utc)
      @address = address
      @numeric = numeric
      @alpha = alpha
      @received_at = received_at
    end

    def to_s
      "received_at=#{received_at.iso8601} " \
      "address=#{address} " \
      "numeric=\"#{numeric}\" " \
      "alpha=\"#{alpha}\""
    end
  end

end
