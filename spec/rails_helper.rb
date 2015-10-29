ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'
require "rack_session_access/capybara"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.include Devise::TestHelpers, type: :controller
  config.include Capybara::DSL
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
#
# module FeatureHelpers
#   def logged_as(user)
#     page.set_rack_session('warden.user.user.key' => User.serialize_into_session(user).unshift("User"))
#   end
# end
# DO MORE RESEARCH
# Look into https://github.com/kylemellander/would-you-rather-/blob/master/spec/features/index_functions_spec.rb
# Want to get Rack_session working for better testing coverage
