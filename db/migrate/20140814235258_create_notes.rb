class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :point_in_track
      t.integer :soundboard_id

      t.timestamps
    end
  end
end
