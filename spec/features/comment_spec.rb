require 'spec_helper'

feature "commenting" do
  before :each do
    sign_up
    sign_up('JaneyGirl')
    create_a_goal('lose weight')
    sign_out
    log_in
    visit ('/users/2/')
  end

  it "comment on a goal displays under that goal" do
    click_link('Comment on this goal')
    fill_in('Comment', :with "Good luck, fatty.")
    click_button('Add Comment')
    expect(page).to have_content('Good luck, fatty')
  end

  it "comment on a user displays under that user" do
    click_link('Comment on this user')
    fill_in('Comment', :with "Good luck on all your goals.")
    click_button('Add Comment')
    expect(page).to have_content('Good luck on all your goals.')
  end

end
