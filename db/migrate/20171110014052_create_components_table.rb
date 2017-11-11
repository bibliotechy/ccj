class CreateComponentsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :components_tables do |t|
      t.string :name
      t.string :local_id
      t.string :previous_id
      t.string :artist_name_en
      t.string :artist_name_jp
      t.text :description_en
      t.text :description_jp
      t.string :title_en
      t.string :title_jp

    end
  end
end
