module Nhim
  class ObjectsController < BaseController

    before_action :find_object!, only: [:rename, :update_name, :remove, :restore, :star, :remove_star]

    SUPPORTED_OBJECT_TYPES = %w(folder file)

    def deleted
      add_breadcrumb('Home', nhim_folders_path)
      add_breadcrumb('Deleted items', nhim_deleted_path)
      @deleted_folders = ::Nhim::Folder.deleted
      @deleted_files = ::Nhim::File.deleted
      respond_to do |f|
        f.html { render layout: !request.xhr? }
        f.js
      end
    end

    def starred
      add_breadcrumb('Home', nhim_folders_path)
      add_breadcrumb('Starred items', nhim_starred_path)
      @starred_folders = ::Nhim::Folder.joins(:stars)
      @starred_files = ::Nhim::File.joins(:stars)
      if nhim_current_user
        filter = {
          ownerable_type: nhim_current_user.class.name,
          ownerable_id: nhim_current_user.id
        }
        @starred_folders.where!(nhim_stars: filter)
        @starred_files.where!(nhim_stars: filter)
      end
      respond_to do |f|
        f.html { render layout: !request.xhr? }
        f.js
      end
    end

    def rename
      render layout: false
    end

    def update_name
      assign_current_folder(@object.parent)
      @object.update(name: params[:new_name])
      respond_to(&:js)
    end

    def star
      @star = ::Nhim::Star.find_or_create_by(nhim_object: @object, ownerable: nhim_current_user)
      @message = @star.persisted? ? "Add #{@object.name} to Starred is success!" : 'Failed!'
      render :refresh_with_message
    end

    def remove_star
      @star = ::Nhim::Star.find_by(nhim_object: @object, ownerable: nhim_current_user)
      @message = @star.delete ? "Remove #{@object.name} from Starred is success!" : 'Failed!'
      render :refresh_with_message
    end

    def remove
      assign_current_folder(@object.parent)
      if @object.deleted_at
        @object.destroy
        @message = "Remove #{@object.name} forever is success!"
        render :refresh_with_message
      else
        @success = @object.update(deleted_at: Time.current)
      end
      respond_to(&:js)
    end

    def restore
      @object.update(deleted_at: nil)
      @message = "Restore #{@object.name} is success!"
      render :refresh_with_message
    end

    private

    def find_object!
      return @object if defined?(@object)
      @object_type, @object_id = params.require([:type, :id])
      raise ::Nhim::ObjectTypeNotSupportError.new(@object_type) if SUPPORTED_OBJECT_TYPES.exclude?(@object_type)
      @object ||= "::Nhim::#{@object_type.classify}".constantize.unscoped.find(@object_id)
    end

  end
end
