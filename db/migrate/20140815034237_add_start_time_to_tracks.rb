class AddStartTimeToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :start_time, :integer
  end
end
