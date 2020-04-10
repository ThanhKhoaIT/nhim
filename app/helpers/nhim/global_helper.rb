module Nhim
  module GlobalHelper

    def tree_folders
      @tree_folders ||= get_subfolders(nil)
    end

    private

    def all_folders
      @all_folders ||= ::Nhim::Folder.pluck(:parent_id, :id, :name, :slug)
    end

    def get_subfolders(filter_id)
      all_folders.each_with_object([]) do |(parent_id, id, name, slug), items|
        items << [[id, name, slug], get_subfolders(id)] if parent_id == filter_id
      end
    end

  end
end
