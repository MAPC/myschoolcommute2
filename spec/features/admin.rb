require 'rails_helper'

RSpec.describe "sign in to admin interface", :type => :feature do
  before :each do
    create(:user)
  end

  it "signs me in" do
    visit '/users/sign_in'
    fill_in 'Email', with: 'example1@example.com'
    fill_in 'Password', with: 'devnull123'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
