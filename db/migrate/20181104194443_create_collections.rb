class CreateCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :collections do |t|
      t.string :name_en
      t.string :name_jp
      t.string :website
      t.text :viewing_policy_en
      t.text :viewing_policy_jp
      t.text :contact_information_en
      t.text :contact_information_jp
      t.text :description_en
      t.text :description_jp
      t.timestamps
    end
  end
end
