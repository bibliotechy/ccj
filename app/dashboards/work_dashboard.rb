require "administrate/base_dashboard"

class WorkDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    components: Field::HasMany,
    artists: Field::HasMany,
    id: Field::Number,
    title_en: Field::Text,
    title_jp: Field::Text,
    description_en: Field::Text,
    description_jp: Field::Text,
    local_id: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :components,
    :artists,
    :id,
    :title_en,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :components,
    :artists,
    :id,
    :title_en,
    :title_jp,
    :description_en,
    :description_jp,
    :local_id,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :components,
    :artists,
    :title_en,
    :title_jp,
    :description_en,
    :description_jp,
    :local_id,
  ].freeze

  # Overwrite this method to customize how works are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(work)
  #   "Work ##{work.id}"
  # end
end
