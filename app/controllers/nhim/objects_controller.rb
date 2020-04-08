module Nhim
  class ObjectsController < BaseController

    before_action :find_object!, only: [:rename, :update_name]

    SUPPORTED_OBJECT_TYPES = %w(folder file)

    def rename
      render layout: false
    end

    def update_name
      assign_current_folder(@object.parent)
      @object.update(name: params[:new_name])
      respond_to(&:js)
    end

    private

    def find_object!
      return @object if defined?(@object)
      @object_type, @object_id = params.require([:type, :id])
      raise Nhim::ObjectTypeNotSupportError.new(@object_type) if SUPPORTED_OBJECT_TYPES.exclude?(@object_type)
      @object ||= "::Nhim::#{@object_type.classify}".constantize.find(@object_id)
    end

  end
end
