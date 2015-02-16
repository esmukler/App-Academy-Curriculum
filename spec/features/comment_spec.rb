require 'spec_helper'

feature "commenting" do
  before :each do
    sign_up
    sign_up('JaneyGirl')
    create_a_goal('lose weight')
  end

  it "comment on a goal displays under that goal" do
  end

  it "comment on a goal DOES NOT display under that goal's user"

  it "comment on a user displays under that user"


  it "comment on a user DOES NOT display under that user's goal"

end
