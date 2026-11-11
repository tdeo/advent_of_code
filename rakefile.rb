# frozen_string_literal: true

require 'active_support/all'
require 'minitest/test_task'

# Minitest 6 no longer autoloads plugins, so load ours explicitly.
test_prelude = 'require "minitest"; Minitest.load :slow_tests'

Minitest::TestTask.create do |t|
  t.test_globs = '*/test/*_test.rb'
  t.test_prelude = test_prelude
  t.warning = true
end

desc 'Run tests'
task default: :test

(2015..Time.now.year).each do |year|
  Minitest::TestTask.create(year) do |t|
    t.test_globs = "#{year}/test/*_test.rb"
    t.test_prelude = test_prelude
    t.warning = true
  end
end
