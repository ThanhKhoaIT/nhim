module Nhim
  class FolderSerializer

    def initialize(folder)
      @folder = folder
    end

    def name
      folder&.name || 'Home'
    end

    def link
      return nhim_routes.nhim_folders_path if is_home?
      nhim_routes.nhim_folder_path(folder)
    end

    def id
      folder&.id
    end

    def subfolders
      is_home? ? ::Nhim::Folder.in_root : folder.subfolders
    end

    def files
      is_home? ? ::Nhim::File.in_root : folder.files
    end

    def breadcrumbs
      return [] if folder.nil?
      items = [folder]
      loop do
        break if items.last.parent.nil?
        items << items.last.parent
      end
      items.reverse
    end

    def is_home?
      folder.nil?
    end

    def is_empty?
      subfolders.empty? && files.empty?
    end

    def js_data
      {
        id: id,
        name: name,
        link: link,
      }.to_json
    end

    private

    attr_reader :folder

    def nhim_routes
      ::Nhim::Engine.routes.url_helpers
    end

  end
end
