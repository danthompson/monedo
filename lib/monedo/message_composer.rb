module Monedo

  class MessageComposer
    def initialize(data)
      @data = data
    end

    def compose
      return unless composable?

      Message.new(@data[:address], @data[:numeric], @data[:alpha])
    end

    private

    def composable?
      [:address, :numeric, :alpha].all? { |k| @data.key?(k) && !@data[k].nil? }
    end
  end

end
