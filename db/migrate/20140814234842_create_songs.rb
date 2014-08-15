class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :duration
      t.string :title
      t.string :genre
      t.integer :user_id

      t.timestamps
    end
  end
end
