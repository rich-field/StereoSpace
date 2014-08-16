class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :duration
      t.boolean :looped, :default => false
      t.integer :song_id
      t.integer :user_id

      t.timestamps
    end
  end
end
