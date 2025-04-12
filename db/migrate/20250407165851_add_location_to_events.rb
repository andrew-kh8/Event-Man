class AddLocationToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :location, :st_point, srid: 4326
    add_column :events, :online, :boolean, default: false, null: false
  end
end
