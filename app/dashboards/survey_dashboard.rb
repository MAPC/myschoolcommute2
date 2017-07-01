require "administrate/base_dashboard"

class SurveyDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    survey_responses: Field::HasMany,
    school: Field::BelongsTo,
    school_name: Field::String,
    id: Field::Number,
    begin: Field::DateTime,
    end: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :survey_responses,
    :school,
    :school_name,
    :begin,
    :end
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :survey_responses,
    :begin,
    :end,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :begin,
    :end,
  ].freeze

  # Overwrite this method to customize how surveys are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(survey)
    "Survey ##{survey.id}"
  end
end
