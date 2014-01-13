require 'spec_helper'

describe "UserSignups" do
  describe "user signup process" do
    it 'loads signup page' do
      visit register_path
      page.should have_content("Login")
    end
    it "generates new user" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit register_path
      fill_in 'First Name:', with: 'Bob'
      fill_in 'Last Name:', with: 'Riley'
      fill_in 'Email:', with: 'bobriley@gmail.com'
      fill_in 'Username:', with: 'bobby1989'
      fill_in 'Password:', with: '987efg'
      fill_in 'Confirm Password:', with: '987efg'
      fill_in 'City:', with: 'Yahupitz'
      select 'Idaho', from: 'State:'
      select 'United States', from: 'country-select'
      click_button 'Create My Account'
      page.should have_content('My Profile')
    end
  end
end
