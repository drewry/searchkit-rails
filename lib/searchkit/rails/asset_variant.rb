module Searchkit
  module Rails
    class AssetVariant
      GEM_ROOT = Pathname.new('../../../../').expand_path(__FILE__)
      attr_reader :searchkit_build, :searchkit_directory

      def initialize(options={})
        @searchkit_build = options[:variant] == :production ? 'production' : 'development'
        @searchkit_directory = GEM_ROOT.join('lib/assets/searchkit-source/').join(@searchkit_build).to_s
      end
    end
  end
end