require 'friendly_id'
require 'securerandom'

module Nhim
  module OwnerAndSlugConcern
    extend ActiveSupport::Concern

    included do
      extend ::FriendlyId
      friendly_id :nhim_slug, use: :slugged

      belongs_to :ownerable, polymorphic: true

      def owner_name
        return nil if Nhim.config.current_user_name_method.blank?
        self.ownerable.try(Nhim.config.current_user_name_method.to_sym)
      end

      private

      def nhim_slug
        SecureRandom.hex.first(12)
      end

    end

  end
end
