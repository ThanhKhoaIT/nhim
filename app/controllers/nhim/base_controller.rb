module Nhim
  class BaseController < ApplicationController

    layout :nhim_layout

    helper ::Nhim::Engine.helpers
    include ::Nhim::ControllerHelper

    before_action :initialize_basic_variables!

    private

    def nhim_layout
      Nhim.config.layout
    end

    def assign_current_folder(folder)
      @current_folder_serializer = ::Nhim::Serializers::FolderSerializer.new(folder)
    end

    def initialize_basic_variables!
      @new_folder = ::Nhim::Folder.new(parent: current_folder)
      @breadcrumbs = []
    end

  end
end
