# frozen_string_literal: true

require 'active_support/all'
require 'minitest/test_task'
require_relative 'minitest/slow_tests_plugin'

Minitest::TestTask.create do |t|
  t.test_globs = '*/test/*_test.rb'
  t.warning = true
end

desc 'Run tests'
task default: :test

(2015..Time.now.year).each do |year|
  Minitest::TestTask.create(year) do |t|
    t.test_globs = "#{year}/test/*_test.rb"
    t.warning = true
  end
end
