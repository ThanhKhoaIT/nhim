module Nhim
  module DisplayHelper

    def nhim_datetime_display(datetime)
      return '-' if datetime.blank?
      datetime.strftime("%m/%d/%Y %I:%M%p")
    end

  end
end
