require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

def copy_searchkit_asset(webpack_file, destination_file)
  full_webpack_path = File.expand_path("../searchkit-builds/build/#{webpack_file}", __FILE__)
  full_destination_path = File.expand_path("../lib/assets/searchkit-source/#{destination_file}", __FILE__)
  FileUtils.cp(full_webpack_path, full_destination_path)
end

namespace :searchkit do
  desc "Run the JS build process to put files in the gem source"
  task update: [:build, :copy]
  
  desc "Build the JS bundles with Webpack"
  task :build do
    Dir.chdir("searchkit-builds") do
      `webpack`
      `NODE_ENV=production webpack -p`
    end
  end

  desc "Copy browser-ready JS files to the gem's asset paths"
  task :copy do
    environments = ["development", "production"]
    environments.each do |environment|
      copy_searchkit_asset("#{environment}/searchkit.js", "#{environment}/searchkit.js")
    end
  end

  desc "Use NPM to install the JavaScript dependencies"
  task :install do
    Dir.chdir("searchkit-builds") do
      `npm install`
    end
  end
end

RSpec::Core::RakeTask.new(:spec)

desc 'Default to run the tests'
task :default => [:spec]