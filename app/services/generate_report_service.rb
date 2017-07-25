class GenerateReportService
  def initialize(survey)
    @survey = survey
  end

  def perform
    filepath = Rails.root.join('lib', 'external_scripts', 'compile.R')

    arguments = [
      ENV['DATABASE_URL'] || 'postgres://localhost/mysc-development', # DB_URL
      @survey.school.schid || '00010505', # ORG_CODE
      @survey.begin.strftime("%Y/%m/%d"), # DATE1
      @survey.end.strftime("%Y/%m/%d"), # DATE2
      @survey.id # survey id
    ]

    Rails.logger.info "The R script command is below"
    Rails.logger.info "Rscript --vanilla #{filepath} #{arguments.join(" ")}"

    output = `Rscript --vanilla #{filepath} #{arguments.join(" ")}`

    Rails.logger.info "Output result is below"
    Rails.logger.info output

    "SurveyReport#{@survey.id}.pdf"
  end
end
