require 'rails'

module Searchkit
  module Rails
    class Railtie < ::Rails::Railtie
      config.searchkit = ActiveSupport::OrderedOptions.new

      # Defaults, you can override in application.rb
      config.searchkit.variant = (::Rails.env.production? ? :production : :development)

      initializer "searchkit_rails.bust_cache", group: :all do |app|
        asset_variant = Searchkit::Rails::AssetVariant.new({ variant: app.config.searchkit.variant })

        sprockets_env = app.assets || app.config.assets # sprockets-rails 3.x attaches this at a different config
        sprockets_env.version = [sprockets_env.version, "searchkit-#{asset_variant.searchkit_build}",].compact.join('-')

      end

      initializer "searchkit_rails.set_variant", after: :engines_blank_point, group: :all do |app|
        asset_variant = Searchkit::Rails::AssetVariant.new({ variant: app.config.searchkit.variant })

        app.config.assets.paths << asset_variant.searchkit_directory
      end

      initializer "searchkit_rails.setup_engine", :group => :all do |app|
        sprockets_env = app.assets || Sprockets # Sprockets 3.x expects this in a different place
      end
    end
  end
end