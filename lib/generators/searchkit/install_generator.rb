module Searchkit
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path '../../templates', __FILE__

      desc 'Create default searchkit.js folder layout and prep application.js'

      class_option :skip_git,
        type: :boolean,
        aliases: '-g',
        default: false,
        desc: 'Skip Git keeps'

      def inject_searchkit
        require_searchkit = "//= require searchkit\n"

        if manifest.exist?
          manifest_contents = File.read(manifest)

          if match = manifest_contents.match(/\/\/=\s+require\s+turbolinks\s+\n/)
            inject_into_file manifest, require_searchkit, { after: match[0] }
          elsif match = manifest_contents.match(/\/\/=\s+require_tree[^\n]*/)
            inject_into_file manifest, require_searchkit, { before: match[0] }
          else
            append_file manifest, require_searchkit
          end
        else
          create_file manifest, require_searchkit
        end
      end

      private

      def manifest
        Pathname.new(destination_root).join('app/assets/javascripts', 'application.js')
      end
    end
  end
end