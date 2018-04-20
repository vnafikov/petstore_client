require 'action_controller/railtie'
require 'bundler/setup'
require 'combustion'
require 'rspec/rails'
require 'simplecov'
require 'spec_helper'
require 'webmock/rspec'

SimpleCov.start :rails do
  minimum_coverage 100

  add_filter 'lib/petstore_client/version.rb'
end

require 'petstore_client'

Combustion.initialize! :active_resource

RSpec.configure do |config|
  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.filter_gems_from_backtrace('petstore_client')
end
