# frozen_string_literal: true

require 'utility_colors'
require 'byebug'

require 'generator_spec'

ENV['RAILS_ENV'] ||= 'test'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    UtilityColors.reset_configuration!

    UtilityColors.configure do |configuration|
      # Enabled Environments
      configuration.enable_environments = [:test]
      configuration.output_filename = 'spec/tmp/exports/utility_colors'
    end
  end

  config.after(:each) do
    UtilityColors.reset_configuration!
  end
end
