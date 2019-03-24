class AddRecordedDateToComponent < ActiveRecord::Migration[5.2]
  def change
    add_column :components, :recording_date, :string
  end
end
