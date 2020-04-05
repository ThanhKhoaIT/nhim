module Nhim
  module FormHelper

    def nhim_form_for(record, options={}, &block)
      options[:builder] ||= ::Nhim::FormBuilder
      options[:url] ||= [:nhim, record]
      form_for(record, options, &block)
    end

    def nhim_remote_form_for(record, options={}, &block)
      options[:remote] = true
      options[:authenticity_token] = true
      nhim_form_for(record, options, &block)
    end

  end
end
