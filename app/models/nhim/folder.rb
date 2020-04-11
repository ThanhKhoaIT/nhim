module Nhim
  class Folder < BaseModel

    include ::Nhim::OwnerAndSlugConcern

    belongs_to :parent, class_name: 'Nhim::Folder'

    has_many :stars, as: :nhim_object
    has_many :subfolders, foreign_key: :parent_id, class_name: 'Nhim::Folder'
    has_many :files

    default_scope { where(deleted_at: nil) }
    scope :deleted, -> { unscoped.where.not(deleted_at: nil) }
    scope :in_root, -> { where(parent: nil) }
    scope :name_ordering, -> { order(:name) }

    validates :name, presence: true

  end
end
