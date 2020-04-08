module Nhim
  class FoldersController < BaseController

    before_action :load_breadcrumbs!

    def index
      respond_to do |f|
        f.html { render layout: !request.xhr? }
        f.js
      end
    end

    def show
      respond_to do |f|
        f.html { render action: :index, layout: !request.xhr? }
        f.js { render action: :index }
      end
    end

    def create
      folder_params = params.require(:folder).permit(:parent_id, :name)
      @folder = ::Nhim::Folder.new(folder_params)
      @folder.ownerable = nhim_has_owner? ? nhim_current_user : nil
      @folder.save
      assign_current_folder(@folder.parent)
      respond_to(&:js)
    end

    private

    def load_breadcrumbs!
      @breadcrumbs = current_folder_serializer.breadcrumbs
    end

  end
end
