class AddBusStopIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :bus_stop_id, :integer
  end
end
