require 'selenium-webdriver'
require "capybara/rspec"
require "capybara"
require "rspec"
require "pry"
require "dotenv/load"

require_relative "./support/features/session_helpers.rb"

chromeOptions = %w[ --test-type --disable-popup-blocking --disable-translate --start-maximized --window-size=1024,800]
caps = Selenium::WebDriver::Remote::Capabilities.chrome('chromeOptions' => { 'args' => chromeOptions })
opts = {
  :browser => :chrome,
  :desired_capabilities => caps
}

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, opts)
end

Capybara.configure do |config|
  config.default_driver = :selenium
  config.app_host = ENV['BASE_URL']
end

Capybara.default_max_wait_time = 10

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Capybara::DSL, :type => :feature
  config.include Capybara::RSpecMatchers
end
