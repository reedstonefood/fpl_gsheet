#$LOAD_PATH << '../lib'
#$:<< File.join(File.dirname(__FILE__), '..')
Dir["../lib/*.rb"].each {|file| require file }
Dir["../lib/fpl-sheet/*.rb"].each {|file| require file }
#require File.expand_path("../../lib", __FILE__)
#require File.expand_path("../../lib/fpl-sheet", __FILE__)
require "bundler/setup"
#require "fpl_gsheet"
RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
