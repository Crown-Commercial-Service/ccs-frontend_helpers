# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  add_filter '/bin/'
  add_filter '/spec/'
end

require 'ccs/frontend_helpers'
require 'capybara'

Dir['spec/support/**/*.rb'].sort.each { |f| require f[5..] }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.default_formatter = 'doc' if config.files_to_run.one?
end
