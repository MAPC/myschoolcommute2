require "administrate/base_dashboard"

class DistrictDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    # schools: Field::HasMany.with_options( scope: -> { School.select(:id,:name,:slug,:schid,:address,:town_mail,:town,:state,:zip,:principal,:phone,:fax,:grades,:schl_type,:district_id,:survey_incentive,:survey_active,:geometry,:muni_id) }),
    id: Field::Number,
    name: Field::String,
    distname: Field::String,
    slug: Field::String,
    startgrade: Field::String,
    endgrade: Field::String,
    distcode4: Field::String,
    distcode8: Field::String,
    districtid_id: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    # :schools,
    :distname,
    :startgrade,
    :endgrade,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    # :schools,
    :id,
    :name,
    :distname,
    :slug,
    :startgrade,
    :endgrade,
    :distcode4,
    :distcode8,
    :districtid_id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    # :schools,
    :name,
    :distname,
    :slug,
    :startgrade,
    :endgrade,
    :distcode4,
    :distcode8,
    :districtid_id,
  ].freeze

  # Overwrite this method to customize how districts are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(district)
    "#{district.distname}"
  end
end
