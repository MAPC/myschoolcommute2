class WelcomeController < ApplicationController
  def index
    @schools_with_active_surveys = School.with_active_surveys
  end
end
