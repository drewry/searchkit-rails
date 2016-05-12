# encoding: utf-8

$:.push File.expand_path('../lib', __FILE__)
require 'searchkit/rails/version'

Gem::Specification.new do |s|
  s.name     = "searchkit-rails"
  s.version  = Searchkit::Rails::VERSION
  s.platform = Gem::Platform::RUBY
  s.date     = File.new("lib/searchkit/rails/version.rb").ctime

  s.authors     = ["Drewry Morris"]
  s.email       = %q{dhmorris@gmail.com}
  s.homepage    = %q{https://github.com/drewry/searchkit-rails}
  s.description = %q{This gem is a wrapper for easily adding searchkit to your rails project.}
  s.summary     = %q{This gem is a wrapper for easily adding searchkit to your rails project.}
  s.license     = "Apache-2.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'rails', '>= 4.2'
  s.add_dependency 'react-rails', '>= 1.7'

  s.add_development_dependency('bundler')
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', '~> 3.4')
  s.add_development_dependency('pry-byebug', '~>3.3.0')
end

