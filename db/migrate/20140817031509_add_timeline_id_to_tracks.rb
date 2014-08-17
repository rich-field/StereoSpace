class AddTimelineIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :timeline_id, :integer
  end
end
