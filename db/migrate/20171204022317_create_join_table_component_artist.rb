class CreateJoinTableComponentArtist < ActiveRecord::Migration[5.1]
  def change
    create_join_table :components, :artists do |t|
      # t.index [:component_id, :artist_id]
      # t.index [:artist_id, :component_id]
    end
  end
end
