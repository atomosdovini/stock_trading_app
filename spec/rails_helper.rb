require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'active_record'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

require 'factory_bot_rails'
FactoryBot.find_definitions

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.fixture_path = "#{::Rails.root}/spec/fixtures"


  config.use_transactional_fixtures = true


  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  Dir[Rails.root.join('spec', 'controllers', '**', '*_spec.rb')].each { |f| require f }

end
