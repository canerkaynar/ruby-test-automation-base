require "capybara"
require "capybara/cucumber"
require "selenium-webdriver"
require "rspec"
require_relative "helper.rb"

World(Helper)

ENV_TYPE = ENV["ENV_TYPE"]
BROWSER = ENV["BROWSER"]

CONFIG = YAML.load_file(File.dirname(__FILE__) + "/config/#{ENV_TYPE}.yml")
# CONFIG = YAML.load_file(File.join(File.dirname(__FILE__), "/config/#{AMBIENTE}.yml"))

# register drivers
Capybara.register_driver :selenium do |app|
  if BROWSER.eql?("chrome_headless")
    option = ::Selenium::WebDriver::Chrome::Options.new(args: ["--headless", "--disable-gpu", "--window-size=1600,1024",
                                                               "--disable-dev-shm-usage", "--no-sandbox"])
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: option)

  elsif BROWSER.eql?("chrome")
    option = ::Selenium::WebDriver::Chrome::Options.new(args: ["--disable-infobars", "window-size=1600,1024"])
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: option)
  end
end

Capybara.configure do |config|
  config.default_driver = :selenium
  config.default_selector = :css
  config.app_host = CONFIG["BASE_URL"]
  config.default_max_wait_time = 10
end

