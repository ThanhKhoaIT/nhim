module Nhim
  class Engine < ::Rails::Engine

    isolate_namespace Nhim

    initializer 'nhim.assets.precompile' do |app|
      app.config.assets.precompile += %w( nhim.css nhim.js )
      app.config.assets.precompile += %w( nhim/*.png )
      app.config.assets.precompile += %w( nhim/*.jpg )
    end

  end
end
