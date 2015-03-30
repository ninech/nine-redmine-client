require 'redmine_client'

RedmineClient::API.configure do |config|
  config.url = 'http://redmine.test'
  config.token = 'abcd'
end

require 'pry'

Dir["./spec/support/**/*.rb"].sort.each { |f| require f}

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.order = :random
  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
