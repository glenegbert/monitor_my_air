require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'As a Public User', type: :feature do
  context 'when logged out' do
    before(:each) do
      visit root_path
    end

    it 'has a login link' do
      expect(page).to have_link('Login With Twitter', href: login_path)
    end
  end


  describe 'browsing' do
   it "can get current conditions and alerts" do
     visit '/'
     fill_in "Zip code", with: "80228"
     find(:css, "#_heart_disease").set(true)
     click_on "Submit"
     expect(page).to have_css("#report")
     expect(page).to have_css("#reports_form")
     expect(page).to have_content("heart disease")
   end
  end
end
