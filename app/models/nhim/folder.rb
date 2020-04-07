module Nhim
  class Folder < BaseModel

    include ::Nhim::OwnerAndSlugConcern

    belongs_to :parent, class_name: 'Nhim::Folder'

    has_many :subfolders, foreign_key: :parent_id, class_name: 'Nhim::Folder'
    has_many :files

    scope :in_root, -> { where(parent: nil) }

    validates :name, presence: true

  end
end
