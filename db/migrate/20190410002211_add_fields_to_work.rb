class AddFieldsToWork < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :creation_date, :string
    add_column :works, :color, :string
    add_column :works, :sound, :string
    add_column :works, :run_time, :string
    add_column :works, :format, :string
  end
end
