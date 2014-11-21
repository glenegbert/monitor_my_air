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

    it 'has a create notifications button' do
      expect(page).to have_css('.notifications-btn')
       page.fill_in('Zip code', with: "80228")
       find(:css, "#_children[value='1']").set(true)
       click_on "Submit"
      expect(page).to have_css('.notifications-btn')
    end

    it 'has a create notifications button' do
      expect(page).to have_css('.historical-data-btn')
       page.fill_in('Zip code', with: "80228")
       find(:css, "#_children[value='1']").set(true)
       click_on "Submit"
      expect(page).to have_css('.historical-data-btn')
    end

    it 'stays on page when notifications button is clicked' do
      expect(page).to have_css('#reports_form')
      expect(page).to_not have_css('#report')
      click_on "Create Notifications"
      expect(page).to have_css('#reports_form')
      expect(page).to_not have_css('#report')
      page.fill_in('Zip code', with: "80228")
      find(:css, "#_children[value='1']").set(true)
      click_on "Submit"
      expect(page).to have_css('#reports_form')
      expect(page).to have_css('#report')
      click_on "Create Notifications"
      expect(page).to have_css('#reports_form')
      expect(page).to have_css('#report')
    end

    it 'stays on page when historical data button is clicked' do
      expect(page).to have_css('#reports_form')
      expect(page).to_not have_css('#report')
      click_on "See Historical Data"
      expect(page).to have_css('#reports_form')
      expect(page).to_not have_css('#report')
      page.fill_in('Zip code', with: "80228")
      find(:css, "#_children[value='1']").set(true)
      click_on "Submit"
      expect(page).to have_css('#reports_form')
      expect(page).to have_css('#report')
      click_on "See Historical Data"
      expect(page).to have_css('#reports_form')
      expect(page).to have_css('#report')
  end

    it "can get current conditions and alerts" do
      fill_in "Zip code", with: "80228"
      find(:css, "#_heart_disease").set(true)
      click_on "Submit"
      expect(page).to have_css("#report")
      expect(page).to have_css("#reports_form")
      expect(page).to have_content("heart disease")
    end
  end
end
