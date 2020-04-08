module Nhim
  class File < BaseModel

    include ::Nhim::OwnerAndSlugConcern

    belongs_to :folder
    alias_method :parent, :folder

    has_many :file_labels
    has_many :labels, through: :file_labels

    default_scope { where(deleted_at: nil) }
    scope :deleted, -> { unscoped.where.not(deleted_at: nil) }
    scope :in_root, -> { where(folder: nil) }

    validates :name, presence: true

  end
end
