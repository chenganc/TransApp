class CreateBusStops < ActiveRecord::Migration[5.0]
  def change
    create_table :bus_stops do |t|
      t.string :stopName
      t.integer :stopNo
      t.decimal :lat
      t.decimal :lng

      t.timestamps
    end
  end
end
