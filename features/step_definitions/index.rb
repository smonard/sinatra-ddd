# frozen_string_literal: true

require 'rubygems'
require 'selenium-webdriver'

Before do
  @driver = Selenium::WebDriver.for :firefox
end

Given('nothing') do
end

When('the main page is accessed') do
  @driver.navigate.to 'http://localhost:9292/'
end

Then('a greeting is displayed') do
  expect(@driver.find_element(id: 'greetings').text).to eq('Hello world :)')
end
