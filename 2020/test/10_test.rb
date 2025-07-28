# frozen_string_literal: true

require 'minitest/autorun'
require_relative('../lib/10_adapter_array')

class AdapterArrayTest < Minitest::Test
  def described_class = AdapterArray

  def test_part1
    assert_equal 35, described_class.new('16
10
15
5
1
11
7
19
6
12
4').part1
  end

  def test_part1_2
    assert_equal 220, described_class.new('28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3').part1
  end

  def test_part2
    assert_equal 8, described_class.new('16
10
15
5
1
11
7
19
6
12
4').part2
  end

  def test_part2_2
    assert_equal 19_208, described_class.new('28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3').part2
  end
end
