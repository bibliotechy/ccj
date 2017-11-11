class AddAritstRefToComponents < ActiveRecord::Migration[5.1]
  def change
    add_reference :components, :artist, foreign_key: true
  end
end
