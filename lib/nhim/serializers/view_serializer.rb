module Nhim
  module Serializers
    class ViewSerializer

      def to_json
        {
          rename_object_path: nhim_routes.rename_nhim_object_path,
          remove_object_path: nhim_routes.remove_nhim_object_path(:js),
        }.to_json
      end

      private

      def nhim_routes
        ::Nhim::Engine.routes.url_helpers
      end

    end
  end
end
