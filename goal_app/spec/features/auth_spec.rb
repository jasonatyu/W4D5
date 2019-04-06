# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_path
    expect(page).to have_content 'New User'
    expect(page).to have_content 'Username'
    expect(page).to have_content 'Password'
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      visit new_user_path
      fill_in 'Username', with: 'testing_username'
      fill_in 'Password', with: 'biscuits'
      click_on 'Sign Up'
      expect(page).to have_content 'testing_username'
    end
  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do 
    user = User.new( username: "joe", password: "joejoe" )
    user.save!
    visit new_session_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Sign In'
    expect(page).to have_content user.username
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do 
  
  end



  scenario 'doesn\'t show username on the homepage after logout'

end