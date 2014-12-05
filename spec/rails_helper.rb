# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'capybara/rspec'
require 'capybara/email/rspec'
require 'capybara/poltergeist'
require 'capybara/user_agent'
require 'factory_girl_rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    require "#{Rails.root}/db/seeds.rb"
  end

  config.infer_spec_type_from_file_location!

  config.include Rails.application.routes.url_helpers
  config.include Capybara::DSL
  config.include Capybara::UserAgent::DSL
  config.include WaitForAjax

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app,
      js_errors: false,
      phantomjs_logger: File.open("#{Rails.root}/log/test_phantomjs.log", "a"),
      phantomjs_options: ['--debug=no', '--load-images=no', 
                          '--ignore-ssl-errors=yes', '--ssl-protocol=any', '--web-security=false'], 
                          debug: false
    )
  end
  

  
  DEBUG = ENV['DEBUG'] || false
  if DEBUG
    Capybara.default_driver = :selenium
  else
    Capybara.default_driver = :rack_test
    Capybara.javascript_driver = :poltergeist
  end
end
