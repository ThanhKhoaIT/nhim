module Nhim
  class File < BaseModel

    include ::Nhim::OwnerAndSlugConcern

    belongs_to :folder
    alias_method :parent, :folder

    has_many :file_labels
    has_many :labels, through: :file_labels

    scope :in_root, -> { where(folder: nil) }

    validates :name, presence: true

  end
end
