module Searchkit
  module Rails
    class Engine < ::Rails::Engine
      initializer 'searchkit-sass.assets.precompile' do |app|
        %w(stylesheets javascripts images).each do |sub|
          app.config.assets.paths << root.join('lib/assets', sub).to_s
        end
      end
    end
  end
end