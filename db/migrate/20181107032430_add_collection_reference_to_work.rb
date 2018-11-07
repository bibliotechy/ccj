class AddCollectionReferenceToWork < ActiveRecord::Migration[5.1]
  def change
    change_table(:works) do |t|
      t.belongs_to :collection, foreign_key: true
    end
  end
end
