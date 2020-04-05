module Nhim
  class BaseController < ApplicationController

    helper ::Nhim::Engine.helpers

    layout :nhim_layout

    private

    def nhim_layout
      Nhim.config.layout
    end

    helper_method :nhim_current_user
    def nhim_current_user
      return nil unless nhim_has_owner?
      self.try(Nhim.current_user_method.to_sym)
    end

    helper_method :nhim_has_owner?
    def nhim_has_owner?
      Nhim.config.current_user_method && respond_to?(Nhim.config.current_user_method.to_sym)
    end

  end
end
