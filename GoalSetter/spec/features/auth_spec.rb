require 'spec_helper'

feature "the signup process" do
  before :each do
    sign_up
  end

  it "has a new user page" do
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      expect(page).to have_content('JohnnyBoy')
    end


  end

end

feature "logging in" do

  it "shows username on the homepage after login" do
    sign_up
    visit ('/session/new')
    fill_in('Username', :with => 'JohnnyBoy')
    fill_in('Password', :with => 'abcdef')
    click_button('Sign In')
    expect(page).to have_content('JohnnyBoy')
  end

end

feature "logging out" do

  it "begins with logged out state" do
    sign_up
    click_button('Log Out')
    visit ('/users/1')
    expect(page).to have_content('Sign In')
  end

  it "doesn't show username on the homepage after logout" do
    sign_up
    click_button('Log Out')
    expect(page).to_not have_content('JohnnyBoy')
  end

end
