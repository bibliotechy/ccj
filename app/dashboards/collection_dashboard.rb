require "administrate/base_dashboard"

class CollectionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    works: Field::HasMany,
    id: Field::Number,
    name_en: Field::String,
    name_jp: Field::String,
    website: Field::String,
    viewing_policy_en: Field::Text,
    viewing_policy_jp: Field::Text,
    contact_information_en: Field::Text,
    contact_information_jp: Field::Text,
    description_en: Field::Text,
    description_jp: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :works,
    :id,
    :name_en,
    :name_jp,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :works,
    :id,
    :name_en,
    :name_jp,
    :website,
    :viewing_policy_en,
    :viewing_policy_jp,
    :contact_information_en,
    :contact_information_jp,
    :description_en,
    :description_jp,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :works,
    :name_en,
    :name_jp,
    :website,
    :viewing_policy_en,
    :viewing_policy_jp,
    :contact_information_en,
    :contact_information_jp,
    :description_en,
    :description_jp,
  ].freeze

  # Overwrite this method to customize how collections are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(collection)
  #   "Collection ##{collection.id}"
  # end
end
