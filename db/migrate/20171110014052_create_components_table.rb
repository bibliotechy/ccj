class CreateComponentsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :components do |t|
      t.string :name
      t.string :local_id
      t.string :previous_id
      t.string :artist_name_en
      t.string :artist_name_jp
      t.text :description_en
      t.text :description_jp
      t.string :contributors_en
      t.date :creation_date
      t.string :color
      t.string :sound
      t.datetime :run_time
      t.string :collection
      t.string :media_type
      t.string :media_format
      t.string :component_type
      t.string :relation
      t.string :film_print_type
      t.integer :fps
      t.string :brand
      t.string :file_name
      t.string :codec
      t.string :codec_id
      t.float :file_size_gb
      t.string :duration
      t.string :bit_rate
      t.string :dimensions
      t.string :display_aspect_ratio
      t.string :bit_depth
      t.string :scan_type
      t.datetime :encoded_date
      t.string :provenance
      t.string :viewing_restrictions
      t.string :terms_governing_use
      t.string :housing_annotations
      t.string :item_annotations
      t.string :condition_notes
      t.string :notes
      t.datetime :date_of_entry
      t.string :cataloger
    end
  end
end
