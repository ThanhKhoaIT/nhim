module Nhim
  class FoldersController < BaseController

    before_action :initialize_basic_variables!

    def index
    end

    def show
      render action: :index
    end

    def create
      folder_params = params.require(:folder).permit(:parent_id, :name)
      @folder = Folder.new(folder_params)
      @folder.ownerable = nhim_has_owner? ? nhim_current_user : nil
      @folder.save
      respond_to(&:js)
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    helper_method :current_folder
    def current_folder
      return if params[:id].blank?
      @current_folder ||= ::Nhim::Folder.friendly.find(params[:id])
    end

    helper_method :get_items
    def get_items(folder)
      if folder.nil?
        return ::Nhim::Folder.in_root, ::Nhim::File.in_root
      else
        return folder.subfolders, folder.files
      end
    end

    def initialize_basic_variables!
      @new_folder = Folder.new(parent: current_folder)
      @breadcrumbs = current_folder&.breadcrumbs || []
    end

  end
end
