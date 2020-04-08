module Nhim
  module FormBuilders
    class StringInput

      include ActionView::Helpers::TagHelper
      include ActionView::Context

      def initialize(context, attribute_name, options)
        @context = context
        @object = context.object
        @attribute_name = attribute_name.to_s
        @options = options
      end

      def render
        content_tag :div, class: ['nhim-input text-input', attribute_name] do
          items = []
          items << context.label(attribute_name, options[:label] || attribute_name.titleize) if options[:label] != false
          items << context.text_field(attribute_name, input_options)
          items.join.html_safe
        end
      end

      private

      attr_reader :context
      attr_reader :object
      attr_reader :attribute_name
      attr_reader :options

      def input_options
        final_options = {
          value: current_value,
          placeholder: options[:placeholder],
        }
        final_options[:id] = options[:id] if options[:id]
        final_options[:name] = options[:name] if options[:name]
        final_options
      end

      def current_value
        options[:value] ||
          object.try(attribute_name) ||
          options[:default] ||
          object.class.columns_hash[attribute_name]&.default
      end

    end
  end
end
