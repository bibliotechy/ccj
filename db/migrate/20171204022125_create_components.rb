class CreateComponents < ActiveRecord::Migration[5.1]
  def change
    create_table :components do |t|
      t.string :audio_reel_capacity
      t.string :audio_reel_size
      t.string :audio_speed
      t.string :bit_depth
      t.string :bit_rate
      t.string :brand
      t.string :cataloger
      t.string :collection
      t.string :color
      t.string :component_type
      t.string :contributors_en
      t.string :contributors_jp
      t.string :creation_date
      t.string :date_of_entry
      t.string :dimensions
      t.string :display_aspect_ratio
      t.string :duration
      t.string :encoded_date
      t.string :file_name
      t.string :file_size_gb
      t.string :film_element
      t.string :film_process_type
      t.string :film_wind
      t.string :fps
      t.string :identifier
      t.string :local_identifer
      t.string :media_format
      t.string :media_type
      t.string :name
      t.string :previous_ids
      t.string :relation
      t.string :run_time
      t.string :scan_type
      t.string :sound
      t.string :video_standard
      t.string :video_stock_length

      t.text :codecs
      t.text :condition_notes
      t.text :description_en
      t.text :description_jp
      t.text :housing_annotations
      t.text :item_annotations
      t.text :provenance
      t.text :notes
      t.text :terms_governing_use
      t.text :viewing_restrictions

      t.belongs_to :collection, foreign_key: true
      t.belongs_to :work, foreign_key: true

      t.timestamps
    end
  end
end
