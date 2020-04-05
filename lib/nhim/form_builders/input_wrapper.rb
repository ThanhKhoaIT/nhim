module Nhim
  module FormBuilders
    class InputWrapper

      include ActionView::Helpers::TagHelper
      include ActionView::Context

      def initialize(context, attribute_name, options)
        @context = context
        @object = context.object
        @attribute_name = attribute_name.to_s
        @options = options
      end

      def render(&block)
        content_tag :div, class: wrap_styles do
          [
            label_element,
            capture(&block),
            error_element,
          ].join.html_safe
        end
      end

      private

      attr_reader :context
      attr_reader :object
      attr_reader :attribute_name
      attr_reader :options

      def error_element
        return nil unless had_error?
        content_tag :small, object.errors[attribute_name].join(', '), class: 'error-inline'
      end

      def label_element
        return nil if options[:label].blank?
        context.label(attribute_name, options[:label] || attribute_name.titleize)
      end

      def wrap_options
        options[:wrap] || {}
      end

      def had_error?
        object.errors[attribute_name].present?
      end

      def wrap_styles
        [
          'nhim-input',
          "#{attribute_name}-input",
          options[:as],
          wrap_options[:class],
        ]
      end

    end
  end
end
