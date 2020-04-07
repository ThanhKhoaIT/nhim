module Nhim
  class BaseController < ApplicationController

    helper ::Nhim::Engine.helpers

    layout :nhim_layout

    private

    def nhim_layout
      Nhim.config.layout
    end

    helper_method :nhim_current_user
    def nhim_current_user
      return nil unless nhim_has_owner?
      self.try(Nhim.current_user_method.to_sym)
    end

    helper_method :nhim_has_owner?
    def nhim_has_owner?
      Nhim.config.current_user_method && respond_to?(Nhim.config.current_user_method.to_sym)
    end

    helper_method :current_folder
    def current_folder
      return nil if params[:id].blank?
      @current_folder ||= ::Nhim::Folder.friendly.find(params[:id])
    end

    helper_method :current_folder_serializer
    def current_folder_serializer
      @current_folder_serializer ||= ::Nhim::FolderSerializer.new(current_folder)
    end

    helper_method :current_folder_js
    def current_folder_js
      current_folder_serializer.js_data
    end

    def assign_current_folder(folder)
      @current_folder_serializer = ::Nhim::FolderSerializer.new(folder)
    end

  end
end
