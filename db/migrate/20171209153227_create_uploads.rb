class CreateUploads < ActiveRecord::Migration[5.1]
  def change
    create_table :uploads do |t|
      t.string :file
      t.boolean :was_ingested
      t.integer :records_upserted
      t.text :error_message

      t.timestamps
    end
  end
end
