module Nhim
  module FormBuilders
    class HiddenInput < StringInput

      def render
        context.hidden_field(attribute_name, input_options)
      end

    end
  end
end
