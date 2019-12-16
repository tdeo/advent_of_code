require "rake/testtask"
require 'minitest/profile'

Rake::TestTask.new do |t|
  t.pattern = '**/test/*.rb'
  t.warning = true
  t.options = "--profile"
end
desc "Run tests"

task default: :test

(2015 .. Time.now.year).each do |year|
  Rake::TestTask.new do |t|
    t.name = year
    t.pattern = "#{year}/test/*.rb"
    t.warning = true
    t.options = '--profile'
  end
end
