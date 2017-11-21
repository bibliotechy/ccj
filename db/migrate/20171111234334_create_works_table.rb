class CreateWorksTable < ActiveRecord::Migration[5.1]
  def change
    create_table :works_tables do |t|
        t.string :local_id
        t.string :title_en
        t.string :title_jp
        t.string :description_en
        t.string :description_jp
    end
  end
end
