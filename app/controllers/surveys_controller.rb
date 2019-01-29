require 'pry-byebug'

class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy, :show_report]
  before_action :authenticate_user!, except: [:show]
  before_action :authenticate_district_user, except: [:show]
  # GET /surveys/1
  # GET /surveys/1.json
  def show
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  def show_report
    redirect_to '/reports/' + generate_report
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)

    respond_to do |format|
      if @survey.save
        format.html { redirect_to @survey.school, notice: 'Survey was successfully created.' }
      else
        format.html { redirect_to School.find(survey_params[:school_id]) }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { render :show, status: :ok, location: @survey }
      else
        format.html { render :edit }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to surveys_url, notice: 'Survey was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    def authenticate_district_user
      redirect_to '/', alert: 'Not authorized - please notify program coordinator to grant access.' unless access_whitelist
    end

    def access_whitelist
      current_user.try(:is_admin?) || current_user.try(:is_district?)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.permit(survey: [:begin, :end, :school_id]).fetch(:survey)
    end

    def generate_report
      write_data_to_file()
      generate_map()

      report_script = Rails.root.join('lib', 'external', 'report', 'compile.R')

      report_args = [
        ENV['DATABASE_URL'] || 'postgres://editor@db.live.mapc.org/myschoolcommute2', # DB_URL
        @survey.school.schid || '00010505', # ORG_CODE
        @survey.begin.strftime("%Y/%m/%d"), # DATE1
        @survey.end.strftime("%Y/%m/%d"), # DATE2
        @survey.id # survey id
      ]

      report_cmd = "Rscript --vanilla #{report_script} #{report_args.join(" ")}"
      Rails.logger.info report_cmd

      report_output = `#{report_cmd}`
      Rails.logger.info report_output

      "SurveyReport#{@survey.id}.pdf"
    end

    def write_data_to_file
      Rails.logger.info "Writing data to .json"

      data = ApplicationController.render(template: 'schools/_school_show', locals: { school: @survey.school })

      file_path = Rails.root.join('lib', 'external', 'school-map', 'build', 'data', "#{@survey.school.schid}.json")
      File.open(file_path, "w") do |f|
        f.write(data)
      end
    end

    def generate_map
      Rails.logger.info "Generating Map"

      render_script = Rails.root.join('lib', 'external', 'school-map', 'render.js')
      `node #{render_script} #{@survey.school.schid}`
    end

end
