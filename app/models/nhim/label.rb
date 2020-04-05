module Nhim
  class Label < BaseModel

    include ::Nhim::OwnerAndSlugConcern

    has_many :file_labels
    has_many :labels, through: :file_labels

    validates :name, presence: true
    validates :color, presence: true

  end
end
