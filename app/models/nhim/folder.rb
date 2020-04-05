module Nhim
  class Folder < BaseModel

    include ::Nhim::OwnerAndSlugConcern

    belongs_to :parent, class_name: 'Nhim::Folder'

    has_many :subfolders, foreign_key: :parent_id, class_name: 'Nhim::Folder'
    has_many :files

    scope :in_root, -> { where(parent: nil) }

    validates :name, presence: true

    def breadcrumbs
      items = [self]
      loop do
        break if items.last.parent.nil?
        items << items.last.parent
      end
      items.reverse
    end

  end
end
