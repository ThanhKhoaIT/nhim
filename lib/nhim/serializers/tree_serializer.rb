module Nhim
  module Serializers
    class TreeSerializer

      def initialize(folder)
        @folder = folder
      end

      def self.as_json(folders)
        folders.map { |folder| self.new(folder).as_json }
      end

      def as_json
        {
          id: folder.id,
          name: folder.name,
          parent_id: folder.parent_id,
          link: nhim_routes.nhim_folder_path(folder),
        }
      end
      private

      attr_reader :folder

      def nhim_routes
        ::Nhim::Engine.routes.url_helpers
      end

    end
  end
end
