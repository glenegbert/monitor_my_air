require 'rails_helper'

context 'when logged in' do
before(:each) do
  Rails.application.routes.draw do
    root to: 'site#index'
    get '/fake_login' => 'fake_sessions#create', as: :fake_login
    get '/login' => redirect('/auth/twitter'), as: :login
    delete "/logout" => "sessions#destroy", as: :logout
  end
  user = User.create(name: 'Jane Doe')
  visit fake_login_path(:user_id => user.id)
end

after(:each) do
  Rails.application.reload_routes!
end

it 'has a logout link' do
  expect(page).to have_link('Logout', href: logout_path)
end
end
