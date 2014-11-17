require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'As a Public User', type: :feature do

  describe 'browsing' do
   it "can get current conditions and alerts" do
     visit '/'
     fill_in "Zip code", with: "80228"
     find(:css, "#_heart_disease").set(true)
     click_on "Submit"
     expect(page).to have_css("#report")
     expect(page).to have_css("#reports_form")
   end
  end
end
