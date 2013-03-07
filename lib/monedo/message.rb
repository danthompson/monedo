module Monedo

  class Message

    def self.from_hash(hash)
      return unless [:address, :numeric, :alpha].all? do |k|
        hash.key?(k) && !hash[k].nil?
      end

      message = Message.new(hash[:address],
                            hash[:numeric],
                            hash[:alpha])
    end

    attr_accessor :address, :numeric, :alpha, :received_at

    def initialize(address, numeric, alpha, received_at = Time.now)
      @address = address
      @numeric = numeric
      @alpha = alpha
      @received_at = received_at.utc.iso8601
    end

    def to_s
      "received_at=#{received_at} " \
      "address=#{address} " \
      "numeric=\"#{numeric}\" " \
      "alpha=\"#{alpha}\""
    end
  end

end
