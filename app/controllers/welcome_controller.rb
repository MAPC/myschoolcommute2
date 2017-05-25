class WelcomeController < ApplicationController
  def index
    @districts = District.active
  end
end
