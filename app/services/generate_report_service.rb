class GenerateReportService
  def initialize(survey)
    @survey = survey
  end

  def perform
    filepath = Rails.root.join('lib', 'external_scripts', 'compile.R')

    arguments = [
      'test',
      'test',
      'test',
      '02010078',
      '2012-06-01',
      '2013-06-01',
      'WORKDIR'
    ]

    output = `Rscript --vanilla #{filepath} #{arguments}`
  end
end