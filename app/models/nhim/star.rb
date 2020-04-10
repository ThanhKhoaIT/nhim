module Nhim
  class Star < BaseModel

    belongs_to :nhim_object, polymorphic: true
    belongs_to :ownerable, polymorphic: true

  end
end
