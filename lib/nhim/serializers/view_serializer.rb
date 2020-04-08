module Nhim
  module Serializers
    class ViewSerializer

      def to_json
        {
          object_rename_path: nhim_routes.rename_nhim_object_path,
        }.to_json
      end

      private

      def nhim_routes
        ::Nhim::Engine.routes.url_helpers
      end

    end
  end
end
