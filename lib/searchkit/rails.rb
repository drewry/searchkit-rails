require 'searchkit/rails/asset_variant'
require 'searchkit/rails/railtie'
require 'searchkit/rails/version'

module Searchkit
  module Rails
    class << self
      def load!
        register_compass_extension if compass?

        if rails?
          register_rails_engine
        elsif lotus?
          register_lotus
        elsif sprockets?
          register_sprockets
        end

        configure_sass
      end

      # Paths
      def gem_path
        @gem_path ||= File.expand_path '..', File.dirname(__FILE__)
      end

      def stylesheets_path
        File.join assets_path, 'stylesheets'
      end

      def assets_path
        @assets_path ||= File.join gem_path, 'lib/assets'
      end

      # Environment detection helpers
      def sprockets?
        defined?(::Sprockets)
      end

      def compass?
        defined?(::Compass::Frameworks)
      end

      def rails?
        defined?(::Rails)
      end

      def lotus?
        defined?(::Lotus)
      end

      private

      def configure_sass
        require 'sass'

        ::Sass.load_paths << stylesheets_path

        ::Sass::Script::Number.precision = [8, ::Sass::Script::Number.precision].max
      end

      def register_compass_extension
        ::Compass::Frameworks.register(
          'bootstrap',
          :version               => Bootstrap::VERSION,
          :path                  => gem_path,
          :stylesheets_directory => stylesheets_path,
          :templates_directory   => File.join(gem_path, 'lib/generators/templates')
        )
      end

      def register_rails_engine
        require 'searchkit/rails/engine'
      end

      def register_lotus
        Lotus::Assets.sources << assets_path
      end
    end
  end
end

Searchkit::Rails.load!