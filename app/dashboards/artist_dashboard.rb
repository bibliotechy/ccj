require "administrate/base_dashboard"

class ArtistDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    components: Field::HasMany,
    works: Field::HasMany,
    id: Field::Number,
    name_en: Field::String,
    name_jp: Field::String,
    viaf_identifier: Field::String,
    local_identifier: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    image: Field::ActiveStorage,
    description_en: Field::Text,
    description_jp: Field::Text,
    external_link: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name_en,
    :name_jp,
    :works,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :works,
    :components,
    :id,
    :name_en,
    :name_jp,
    :description_en,
    :description_jp,
    :image,
    :viaf_identifier,
    :local_identifier,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :works,
    :components,
    :name_en,
    :name_jp,
    :description_en,
    :description_jp,
    :external_link,
    :image,
    :viaf_identifier,
    :local_identifier,
  ].freeze

  # Overwrite this method to customize how artists are displayed
  # across all pages of the admin dashboard.
  #
   def display_resource(artist)
     artist.name
   end
end
