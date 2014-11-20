require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the application', type: :feature do

  context 'when logged in' do
   before(:each) do
      user = User.create({provider: "twitter", uid: 1, name: "Sara", oauth_token: "token", oauth_secret: "secret" })
      log_in(user)
    end
    it 'has a login link' do
      expect(page).to have_link('Logout')
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
