class AddVideoUrlToWork < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :video_url, :string
  end
end
