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

  end

  it 'lets another user see a user\'s public goals' do
  end

  it 'prevents another user see a user\'s private goals' do

  end

  it 'lets a user update the status of their goals' do

  end
end
