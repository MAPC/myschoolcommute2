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
      @school = School.find(params[:school_id])
      @all_surveys = Survey.select(:id).where(:school_id => @school.id).all
      # binding.pry
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
        format.json { render json: {message: "Survey response was successfully created."} }
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
      params.require(:survey_response).permit(
        :geometry,
        :question,
        :mode,
        :shed,
        :distance,
        :survey_id,
        :grade_0,
        :to_school_0,
        :dropoff_0,
        :from_school_0,
        :pickup_0,
        :grade_1,
        :to_school_1,
        :dropoff_1,
        :from_school_1,
        :pickup_1,
        :grade_2,
        :to_school_2,
        :dropoff_2,
        :from_school_2,
        :pickup_2,
        :grade_3,
        :to_school_3,
        :dropoff_3,
        :from_school_3,
        :pickup_3,
        :grade_4,
        :to_school_4,
        :dropoff_4,
        :from_school_4,
        :pickup_4,
        :grade_5,
        :to_school_5,
        :dropoff_5,
        :from_school_5,
        :pickup_5,
        :grade_6,
        :to_school_6,
        :dropoff_6,
        :from_school_6,
        :pickup_6,
        :grade_7,
        :to_school_7,
        :dropoff_7,
        :from_school_7,
        :pickup_7,
        :grade_8,
        :to_school_8,
        :dropoff_8,
        :from_school_8,
        :pickup_8,
        :grade_9,
        :to_school_9,
        :dropoff_9,
        :from_school_9,
        :pickup_9,
        :grade_10,
        :to_school_10,
        :dropoff_10,
        :from_school_10,
        :pickup_10,
        :grade_11,
        :to_school_11,
        :dropoff_11,
        :from_school_11,
        :pickup_11,
        :grade_12,
        :to_school_12,
        :dropoff_12,
        :from_school_12,
        :pickup_12,
        :grade_13,
        :to_school_13,
        :dropoff_13,
        :from_school_13,
        :pickup_13,
        :grade_14,
        :to_school_14,
        :dropoff_14,
        :from_school_14,
        :pickup_14,
        :grade_15,
        :to_school_15,
        :dropoff_15,
        :from_school_15,
        :pickup_15,
        :grade_16,
        :to_school_16,
        :dropoff_16,
        :from_school_16,
        :pickup_16,
        :grade_17,
        :to_school_17,
        :dropoff_17,
        :from_school_17,
        :pickup_17,
        :grade_18,
        :to_school_18,
        :dropoff_18,
        :from_school_18,
        :pickup_18,
        :grade_19,
        :to_school_19,
        :dropoff_19,
        :from_school_19,
        :pickup_19,
        :nr_vehicles,
        :nr_licenses
                                            )
    end
end
