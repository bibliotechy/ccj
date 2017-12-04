class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.text :title_en
      t.text :title_jp
      t.text :description_en
      t.text :description_jp
      t.string :local_id

      t.timestamps
    end
  end
end
