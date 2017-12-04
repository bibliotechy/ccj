class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.text :name_en
      t.text :name_jp
      t.string :viaf_identifier
      t.string :local_identifier

      t.timestamps
    end
  end
end
