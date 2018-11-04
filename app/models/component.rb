class Component < ApplicationRecord
  belongs_to :work
  has_and_belongs_to_many :artists, dependent: :destroy

  after_save :index_work_record

  def index_work_record
    Work.find(work_id).index_record
  end

  def to_solr
    {
      local_identifer_t: local_identifer,
      component_identifier_t: identifier,
      component_previous_ids_t: previous_ids,
      component_description_en_t: description_en,
      component_description_jp_t: description_jp,
      color_t: color,
      sound_t: sound,
      run_time_t: run_time,
      collection_t: collection,
      collection_facet: collection,
      media_type_t: media_type,
      media_type_facet: media_type,
      media_format_t: media_format,
      media_format_facet: media_format,
      component_type_t: component_type,
      component_type_facet: component_type,
      relation_t: relation,
      film_process_type_t: film_process_type,
      film_process_type_facet: film_process_type,
      film_element_t: film_element,
      film_wind_t: film_wind,
      audio_speed_t: audio_speed,
      audio_reel_size_t: audio_reel_size,
      audio_reel_capacity_t: audio_reel_capacity,
      video_stock_length_t: video_stock_length,
      video_standard_t: video_standard,
      fps_t: fps,
      brand_t: brand,
      file_name_t: file_name,
      codec_t: codecs,
      file_size_gb_t: file_size_gb,
      duration_t: duration,
      bit_rate_t: bit_rate,
      dimensions_t: dimensions,
      dimensions_facet: dimensions,
      display_aspect_ratio_t: display_aspect_ratio,
      bit_depth_t: bit_depth,
      bit_depth_facet: bit_depth,
      scan_type_t: scan_type,
      encoded_date_t: encoded_date,
      provenance_t: provenance,
      viewing_restrictions_t: viewing_restrictions,
      viewing_restrictions_facet: viewing_restrictions,
      terms_governing_use_t: terms_governing_use,
      housing_annotations_t: housing_annotations,
      item_annotations_t: item_annotations,
      condition_notes_t: condition_notes,
      notes_t: notes,
      date_of_entry_t: date_of_entry,
      cataloger_t: cataloger,
      pub_date: creation_date,
    }
  end

  def to_s
    identifier
  end
end
