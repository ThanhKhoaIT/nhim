module Nhim
  class FileLabel < BaseModel

    belongs_to :file
    belongs_to :label

    validates :file, presence: true
    validates :label, presence: true
    validates :file, uniqueness: { scope: :label }

  end
end
