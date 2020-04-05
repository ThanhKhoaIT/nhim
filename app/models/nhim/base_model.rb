module Nhim
  class BaseModel < ::ActiveRecord::Base
    self.abstract_class = true

    def self.belongs_to(relationship, options={})
      options[:optional] = true if ActiveRecord::VERSION::MAJOR >= 5
      super(relationship, options)
    end

  end
end
