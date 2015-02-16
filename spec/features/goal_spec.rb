require 'spec_helper'

feature "goals" do
  before :each do
    sign_up
    sign_up('JaneyGirl')
  end

  it 'lets a user see their public goals' do
    create_a_goal('lose weight')
    expect(page).to have_content('lose weight')
  end

  it 'lets a user see their private goals' do
    create_a_goal('read a book', 'PRIVATE')
    expect(page).to have_content('read a book')
  end

  it 'lets another user see a user\'s public goals' do
    create_a_goal('lose weight')
    sign_out
    log_in('JohnnyBoy')
    visit ('/users/2/')
    expect(page).to have_content('lose weight')
  end

  it 'prevents a user see another user\'s private goals' do
    create_a_goal('lose weight', 'PRIVATE')
    sign_out
    log_in('JohnnyBoy')
    visit ('/users/2/')
    expect(page).to_not have_content('lose weight')
  end

  it 'lets a user update the status of their goals' do
    create_a_goal('lose weight')
    expect(page).to have_content('INCOMPLETE')
    click_link('Edit Goal')
    choose('COMPLETE')
    expect(page).to have_content('COMPLETE')
  end

  it 'does not let a user edit another user\'s goals' do
    create_a_goal('lose weight')
    sign_out
    log_in
    visit ('/users/2/')
    expect(page).to_not have_content('Edit')
  end

  it 'should allow a user to delete their own goals' do
    create_a_goal('lose weight')
    click_button('Delete')
    expect(page).to_not have_content('lose weight')
  end


  it 'should not allow a user to delete another user\'s goals' do
    create_a_goal('lose weight')
    sign_out
    log_in
    visit ('/users/2/')
    expect(page).to_not have_content('Delete')
  end
end
