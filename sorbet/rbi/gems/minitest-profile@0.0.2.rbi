# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `minitest-profile` gem.
# Please instead update this file by running `bin/tapioca gem minitest-profile`.

# source://minitest-profile//lib/minitest/profile_plugin.rb#3
module Minitest
  class << self
    # source://minitest/5.11.3/lib/minitest.rb#150
    def __run(reporter, options); end

    # source://minitest/5.11.3/lib/minitest.rb#74
    def after_run(&block); end

    # source://minitest/5.11.3/lib/minitest.rb#52
    def autorun; end

    # source://minitest/5.11.3/lib/minitest.rb#29
    def backtrace_filter; end

    # source://minitest/5.11.3/lib/minitest.rb#29
    def backtrace_filter=(_arg0); end

    # source://minitest/5.11.3/lib/minitest.rb#968
    def clock_time; end

    # source://minitest/5.11.3/lib/minitest.rb#41
    def extensions; end

    # source://minitest/5.11.3/lib/minitest.rb#41
    def extensions=(_arg0); end

    # source://minitest/5.11.3/lib/minitest.rb#235
    def filter_backtrace(bt); end

    # source://minitest/5.11.3/lib/minitest.rb#46
    def info_signal; end

    # source://minitest/5.11.3/lib/minitest.rb#46
    def info_signal=(_arg0); end

    # source://minitest/5.11.3/lib/minitest.rb#78
    def init_plugins(options); end

    # source://minitest/5.11.3/lib/minitest.rb#85
    def load_plugins; end

    # source://minitest/5.11.3/lib/minitest.rb#23
    def parallel_executor; end

    # source://minitest/5.11.3/lib/minitest.rb#23
    def parallel_executor=(_arg0); end

    # source://minitest-profile//lib/minitest/profile_plugin.rb#11
    def plugin_profile_init(options); end

    # source://minitest-profile//lib/minitest/profile_plugin.rb#5
    def plugin_profile_options(opts, options); end

    # source://minitest/5.11.3/lib/minitest.rb#163
    def process_args(args = T.unsafe(nil)); end

    # source://minitest/5.11.3/lib/minitest.rb#36
    def reporter; end

    # source://minitest/5.11.3/lib/minitest.rb#36
    def reporter=(_arg0); end

    # source://minitest/5.11.3/lib/minitest.rb#120
    def run(args = T.unsafe(nil)); end

    # source://minitest/5.11.3/lib/minitest.rb#959
    def run_one_method(klass, method_name); end
  end
end

# source://minitest/5.11.3/lib/minitest.rb#12
Minitest::ENCS = T.let(T.unsafe(nil), TrueClass)

# source://minitest-profile//lib/minitest/profile_plugin.rb#15
class Minitest::ProfileReporter < ::Minitest::AbstractReporter
  # @return [ProfileReporter] a new instance of ProfileReporter
  #
  # source://minitest-profile//lib/minitest/profile_plugin.rb#20
  def initialize(options); end

  # Returns the value of attribute io.
  #
  # source://minitest-profile//lib/minitest/profile_plugin.rb#18
  def io; end

  # Sets the attribute io
  #
  # @param value the value to set the attribute io to.
  #
  # source://minitest-profile//lib/minitest/profile_plugin.rb#18
  def io=(_arg0); end

  # source://minitest-profile//lib/minitest/profile_plugin.rb#25
  def record(result); end

  # source://minitest-profile//lib/minitest/profile_plugin.rb#29
  def report; end

  # Returns the value of attribute results.
  #
  # source://minitest-profile//lib/minitest/profile_plugin.rb#18
  def results; end

  # Sets the attribute results
  #
  # @param value the value to set the attribute results to.
  #
  # source://minitest-profile//lib/minitest/profile_plugin.rb#18
  def results=(_arg0); end

  # source://minitest-profile//lib/minitest/profile_plugin.rb#43
  def sorted_results; end
end

# source://minitest-profile//lib/minitest/profile_plugin.rb#16
Minitest::ProfileReporter::VERSION = T.let(T.unsafe(nil), String)

# source://minitest/5.11.3/lib/minitest.rb#11
Minitest::VERSION = T.let(T.unsafe(nil), String)
