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

    output = `Rscript --vanilla #{filepath} #{arguments.join(" ")}`
  end
end
