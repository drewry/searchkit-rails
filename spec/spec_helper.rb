require 'rubygems'
require 'rspec'
require 'pathname'
require 'pry-byebug'

ROOT = Pathname(File.expand_path(File.join(File.dirname(__FILE__), '..')))
$LOAD_PATH << File.join(ROOT, 'lib')
$LOAD_PATH << File.join(ROOT, 'lib', 'searchkit')
require File.join(ROOT, 'lib', 'searchkit-rails.rb')

RSpec.configure do |config|
end