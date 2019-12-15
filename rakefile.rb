require "rake/testtask"
require 'minitest/profile'

Rake::TestTask.new do |t|
  t.pattern = '**/test/*.rb'
  t.warning = true
  t.options = "--profile"
end
desc "Run tests"

task default: :test

Rake::TestTask.new do |t|
  t.name = '2019'
  t.pattern = '2019/test/*.rb'
  t.warning = true
  t.options = '--profile'
end

