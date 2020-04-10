module Nhim
  module ControllerHelper

    def add_breadcrumb(name, path = nil)
      @breadcrumbs << [name, path]
    end

    def nhim_current_user
      return nil unless nhim_has_owner?
      self.try(Nhim.current_user_method.to_sym)
    end

    def nhim_has_owner?
      Nhim.config.current_user_method && respond_to?(Nhim.config.current_user_method.to_sym)
    end

    def current_folder
      return nil if params[:folder_id].blank?
      @current_folder ||= ::Nhim::Folder.friendly.find(params[:folder_id])
    end

    def current_folder_serializer
      @current_folder_serializer ||= ::Nhim::Serializers::FolderSerializer.new(current_folder)
    end

    def current_folder_js
      current_folder_serializer.js_data
    end

    def folder_is_starred
      @folder_is_starred ||= ::Nhim::Star.where(ownerable: nhim_current_user, nhim_object_type: 'Nhim::Folder').pluck(:nhim_object_id)
    end

    def file_is_starred
      @file_is_starred ||= ::Nhim::Star.where(ownerable: nhim_current_user, nhim_object_type: 'Nhim::File').pluck(:nhim_object_id)
    end

  end
end
