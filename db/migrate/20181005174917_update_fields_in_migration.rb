class UpdateFieldsInMigration < ActiveRecord::Migration[5.1]
  def self.up
    change_table(:components) do |t|
      t.string :film_element
      t.string :film_wind
      t.string :audio_speed
      t.string :audio_reel_size
      t.string :audio_reel_capacity
      t.string :video_stock_length
      t.string :video_standard
      t.text   :codecs
    end
    rename_column :components, :film_print_type, :film_process_type
    remove_column :components, :codec, :string
    remove_column :components, :codec_id, :string
  end
end
