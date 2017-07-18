require 'rails_helper'

RSpec.describe "submit a survey", :type => :feature do
  before :each do
    @user = create(:user)
    create(:school, :skip_update_sheds)
  end

  it "creates a survey" do
    sign_in @user
    visit '/districts'
    click_link 'Lexington'
    click_link 'MLK High School'
    fill_in 'survey[begin]', with: Date.today.to_s
    fill_in 'survey[end]', with: Date.tomorrow.to_s
    click_button 'Submit Survey'
    expect(page).to have_content 'Survey was successfully created.'
  end
end
