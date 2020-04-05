module Nhim
  class Error < StandardError; end

  class InputTypeNotSupport < Error

    def initialize(type, attribute_name)
      @type = type
      @attribute_name = attribute_name
      super([type, attribute_name])
    end

    def message
      "Nhim is not supported #{@type} for input (#{@attribute_name})"
    end

  end
end
