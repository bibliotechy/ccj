class CreateArtistsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :artists_tables do |t|
      t.string :local_id
      t.string :artist_name_en
      t.string :artist_name_jp
      t.string :viaf_id
    end
  end
end
