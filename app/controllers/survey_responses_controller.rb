class SurveyResponsesController < ApplicationController
  before_action :set_survey_response, only: [:show, :edit, :update, :destroy]

  # GET /survey_responses
  # GET /survey_responses.json
  def index
    respond_to do |format|
      format.csv { send_data SurveyResponse.to_csv }
    end
  end

  # GET /survey_responses/1
  # GET /survey_responses/1.json
  def show
  end

  # GET /survey_responses/new
  def new
    if params[:school_id]
      @survey_response = SurveyResponse.new(school: School.find(params[:school_id]))
    else
      @survey_response = SurveyResponse.new
    end
  end

  # GET /survey_responses/1/edit
  def edit
  end

  # POST /survey_responses
  # POST /survey_responses.json
  def create
    @survey_response = SurveyResponse.new(survey_response_params)

    respond_to do |format|
      if @survey_response.save
        format.html { redirect_to thankyou_survey_response_path(@survey_response), notice: 'Survey response was successfully created.' }
      else
        format.html { redirect_to '/', notice: 'Something went wrong. Please contact an administrator.' }
      end
    end
  end

  # PATCH/PUT /survey_responses/1
  # PATCH/PUT /survey_responses/1.json
  def update
    respond_to do |format|
      if @survey_response.update(survey_response_params)
        format.html { redirect_to @survey_response, notice: 'Survey response was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey_response }
      else
        format.html { render :edit }
        format.json { render json: @survey_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_responses/1
  # DELETE /survey_responses/1.json
  def destroy
    @survey_response.destroy
    respond_to do |format|
      format.html { redirect_to survey_responses_url, notice: 'Survey response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def thankyou
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey_response
      @survey_response = SurveyResponse.find(params[:id])
    end

    def survey_response_params
      keys = params[:survey_response].keys
      params.permit(survey_response: [keys]).fetch(:survey_response)
    end
end
