class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :point_in_segment
      t.integer :sample_id
      t.integer :segment_id
      t.string :sample_path

      t.timestamps
    end
  end
end
