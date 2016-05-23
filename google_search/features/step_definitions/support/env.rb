 require 'capybara'
 require 'capybara/cucumber'
 require 'capybara/rspec'
 require 'selenium/webdriver'
 require 'site_prism'
 require 'rspec'
 require 'require_all'
 require 'csv'
 require_all File.dirname(__FILE__) + '/../../page_objects'

 Before do
      Capybara.register_driver :selenium  do |app|
        puts "Running Firefox on Local host #{Time.now.strftime '%Y-%m-%d %H:%M'}"
        profile = Selenium::WebDriver::Firefox::Profile.new
        profile["network.proxy.type"] = 1
        profile["network.proxy.http"] = "dev01isa01"
        profile["network.proxy.http_port"] = 8080
        profile["network.proxy.ssl"] = "dev01isa01"
        profile["network.proxy.ssl_port"] = 8080
        profile["network.proxy.ftp"] = "dev01isa01"
        profile["network.proxy.ftp_port"] = 8080
        profile["network.proxy.socks"] = "dev01isa01"
        profile["network.proxy.socks_port"] = 8080
        Capybara::Selenium::Driver.new(app, :profile => profile)
      end

      @app ||= App.new
   
      Capybara.default_driver = :selenium
      Capybara.current_session.driver.browser.manage.window.maximize
 end

