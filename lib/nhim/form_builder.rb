require 'nhim/form_builders/input_wrapper'
require 'nhim/form_builders/string_input'
require 'nhim/form_builders/hidden_input'

module Nhim
  class FormBuilder < ::ActionView::Helpers::FormBuilder

    include ActionView::Helpers::TagHelper
    include ActionView::Context

    def input(attribute_name, options = {}, &block)
      input_builder = detect_input_builder(attribute_name, options)
      wrapper = ::Nhim::FormBuilders::InputWrapper.new(self, attribute_name, options)
      wrapper.render do
        input_builder.render
      end
    end

    private

    def detect_input_builder(attribute_name, options)
      input_type = options[:as] || object.class.columns_hash[attribute_name.to_s].type || :string
      input_class = "::Nhim::FormBuilders::#{input_type.to_s.classify}Input".safe_constantize
      raise ::Nhim::InputTypeNotSupport.new(input_type, attribute_name) if input_class.nil?
      input_class.new(self, attribute_name, options)
    end

  end
end
