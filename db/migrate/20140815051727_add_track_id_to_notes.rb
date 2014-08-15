class AddTrackIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :track_id, :integer
  end
end
