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
        require_searchkit_js  = "//= require searchkit\n"
        require_searchkit_css = "*= require searchkit\n"

        # Inject on js
        if js_manifest.exist?
          manifest_contents = File.read(js_manifest)

          if match = manifest_contents.match(/\/\/=\s+require\s+react\s+\n/)
            inject_into_file js_manifest, require_searchkit_js, { before: match[0] }
          else
            append_file js_manifest, require_searchkit_js
          end
        else
          create_file js_manifest, require_searchkit_js
        end

        # Inject on css
        if css_manifest.exist?
          manifest_contents = File.read(css_manifest)

          if match = manifest_contents.match(/\/\/=\s+require_tree[^\n]*/)
            inject_into_file css_manifest, require_searchkit_css, { after: match[0] }
          else
            append_file css_manifest, require_searchkit_css
          end
        else
          create_file css_manifest, require_searchkit_css
        end
      end

      private

      def js_manifest
        Pathname.new(destination_root).join('app/assets/javascripts', 'application.js')
      end

      def css_manifest
        Pathname.new(destination_root).join('app/assets/stylesheets', 'application.css')
      end
    end
  end
end