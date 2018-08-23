require "rake/testtask"
require 'minitest/profile'

Rake::TestTask.new do |t|
  t.pattern = '**/test/*.rb'
  t.warning = true
  t.options = "--profile"
end
desc "Run tests"

task default: :test
