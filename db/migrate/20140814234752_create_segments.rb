class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.integer :duration
      t.integer :start_time
      t.boolean :looped, :default => false
      t.integer :timeline_id

      t.timestamps
    end
  end
end
