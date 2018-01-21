require "administrate/base_dashboard"

class ComponentDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    work: Field::BelongsTo,
    artists: Field::HasMany,
    id: Field::Number,
    local_identifer: Field::String,
    identifier: Field::String,
    previous_ids: Field::String,
    description_en: Field::Text,
    description_jp: Field::Text,
    contributors_jp: Field::String,
    creation_date: Field::DateTime,
    color: Field::String,
    sound: Field::String,
    run_time: Field::DateTime,
    collection: Field::String,
    media_type: Field::String,
    media_format: Field::String,
    component_type: Field::String,
    relation: Field::String,
    film_print_type: Field::String,
    fps: Field::Number,
    brand: Field::String,
    file_name: Field::String,
    codec: Field::String,
    codec_id: Field::String,
    file_size_gb: Field::Number.with_options(decimals: 2),
    duration: Field::String,
    bit_rate: Field::String,
    dimensions: Field::String,
    display_aspect_ratio: Field::String,
    bit_depth: Field::String,
    scan_type: Field::String,
    encoded_date: Field::DateTime,
    provenance: Field::Text,
    viewing_restrictions: Field::Text,
    terms_governing_use: Field::Text,
    housing_annotations: Field::Text,
    item_annotations: Field::Text,
    condition_notes: Field::Text,
    notes: Field::Text,
    date_of_entry: Field::DateTime,
    cataloger: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :local_identifer,
    :work,
    :artists,
    :id
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :work,
    :artists,
    :id,
    :local_identifer,
    :identifier,
    :previous_ids,
    :description_en,
    :description_jp,
    :contributors_jp,
    :creation_date,
    :color,
    :sound,
    :run_time,
    :collection,
    :media_type,
    :media_format,
    :component_type,
    :relation,
    :film_print_type,
    :fps,
    :brand,
    :file_name,
    :codec,
    :codec_id,
    :file_size_gb,
    :duration,
    :bit_rate,
    :dimensions,
    :display_aspect_ratio,
    :bit_depth,
    :scan_type,
    :encoded_date,
    :provenance,
    :viewing_restrictions,
    :terms_governing_use,
    :housing_annotations,
    :item_annotations,
    :condition_notes,
    :notes,
    :date_of_entry,
    :cataloger,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :work,
    :artists,
    :local_identifer,
    :identifier,
    :previous_ids,
    :description_en,
    :description_jp,
    :contributors_jp,
    :creation_date,
    :color,
    :sound,
    :run_time,
    :collection,
    :media_type,
    :media_format,
    :component_type,
    :relation,
    :film_print_type,
    :fps,
    :brand,
    :file_name,
    :codec,
    :codec_id,
    :file_size_gb,
    :duration,
    :bit_rate,
    :dimensions,
    :display_aspect_ratio,
    :bit_depth,
    :scan_type,
    :encoded_date,
    :provenance,
    :viewing_restrictions,
    :terms_governing_use,
    :housing_annotations,
    :item_annotations,
    :condition_notes,
    :notes,
    :date_of_entry,
    :cataloger,
  ].freeze

  # Overwrite this method to customize how components are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(component)
  #   "Component ##{component.id}"
  # end
end
