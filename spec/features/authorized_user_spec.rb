require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the application', type: :feature do

  context 'when logged in' do
   before(:each) do
     Condition.create(name: "heart_disease")
      user = User.create({provider: "twitter", uid: 1, name: "Sara", oauth_token: "token", oauth_secret: "secret" })
      log_in(user)
    end
    it 'has a logout link' do
      expect(page).to have_link('Logout')
    end

    it 'has a "my notifications" link in user dropdown' do
      click_on("drop-down")
      click_on("My Notifications")
      expect(page).to have_css("#notifications-index")
    end

    xit 'can add notifications' do
      click_on("drop-down")
      click_on("My Notifications")
      click_on("Create a New Notification")
      expect(page).to have_css("#new-notification-form")
      page.fill_in('Name', with: "My Test Notification")
      page.fill_in('Zip code', with: "16055")
      page.fill_in('Email', with: "Test@Test.com")
      page.fill_in('Phone number', with: "3035649379")
      find(:css, "#notification_condition_ids_1").set(true)
      click_on("Create Notification")
      expect(page).to have_css("#notifications-index")
      expect(page).to have_content("My Test Notification")
    end

    it 'has a "create notifications" link on the home page' do
      click_on("Create Notifications")
      expect(page).to have_css("#notifications-index")
    end

    it 'has a "create notifications" link on the report page' do
      page.fill_in('Zip code', with: "16055")
      find(:css, "#older_adult").set(true)
      click_on "Submit"
      click_on("Create Notifications")
      expect(page).to have_css("#notifications-index")
    end
  end
end

def log_in(user)
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    'provider' => 'twitter',
    'uid' => user.uid,
    'info' => { "name" => user.name, "image" => user.image },
    'credentials' => {"token" => user.oauth_token, "secret" => user.oauth_secret }
 })
 visit "/auth/twitter/callback"
end
