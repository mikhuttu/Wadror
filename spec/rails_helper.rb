require 'simplecov'
SimpleCov.start('rails')

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
end


  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def sign_up(credentials)
    visit signup_path
    fill_in('user_username', with:credentials[:user_username])
    fill_in('user_password', with:credentials[:user_password])
    fill_in('user_password_confirmation', with:credentials[:user_password_confirmation])
  end
