module Nhim

  class Config

    attr_accessor :name
    attr_accessor :layout
    attr_accessor :current_user_method
    attr_accessor :current_user_name_method

    def initialize
      self.name = 'Nhím'
      self.layout = 'nhim/base'
      self.current_user_method = :current_user
      self.current_user_name_method = :name
    end

  end

  def self.config
    @config ||= Nhim::Config.new
    yield @config if block_given?
    @config
  end

end
