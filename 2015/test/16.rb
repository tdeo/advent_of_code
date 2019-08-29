require 'minitest/autorun'
require_relative('../lib/16_aunt_sue.rb')

describe AuntSue do
  before { @k = AuntSue }

  def test_part1
    instance = @k.new("Sue 1: chicken: 1\nSue 2: chicken: 2")
    instance.instance_variable_set('@result', { 'chicken' => '2' })
    assert_equal "2", instance.part1
  end
end
