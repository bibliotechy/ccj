class CreateComponents < ActiveRecord::Migration[5.1]
  def change
    create_table :components do |t|
      t.string :name
      t.string :local_identifer
      t.string :identifier
      t.string :previous_ids
      t.belongs_to :work, foreign_key: true
      t.text :description_en
      t.text :description_jp
      t.string :contributors_en
      t.string :contributors_jp
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
      t.text :provenance
      t.text :viewing_restrictions
      t.text :terms_governing_use
      t.text :housing_annotations
      t.text :item_annotations
      t.text :condition_notes
      t.text :notes
      t.date :date_of_entry
      t.string :cataloger

      t.timestamps
    end
  end
end
