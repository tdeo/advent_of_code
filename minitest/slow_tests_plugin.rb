# frozen_string_literal: true

require 'minitest/test'

module SlowTestsBypass
  def slow_test!
    return unless ENV.key?('CI')

    skip('Skipping slow test')
  end
end

Minitest::Test.include(SlowTestsBypass)
