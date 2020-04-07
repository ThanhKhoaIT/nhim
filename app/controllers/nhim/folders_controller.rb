module Nhim
  class FoldersController < BaseController

    before_action :initialize_basic_variables!

    def index
      respond_to do |f|
        f.html
        f.js
      end
    end

    def show
      respond_to do |f|
        f.html { render action: :index }
        f.js { render action: :index }
      end
    end

    def create
      folder_params = params.require(:folder).permit(:parent_id, :name)
      @folder = Folder.new(folder_params)
      @folder.ownerable = nhim_has_owner? ? nhim_current_user : nil
      @folder.save
      assign_current_folder(@folder.parent)
      respond_to(&:js)
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def initialize_basic_variables!
      @new_folder = Folder.new(parent: current_folder)
    end

  end
end
