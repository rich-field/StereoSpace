class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :sound
      t.integer :soundboard_id

      t.timestamps
    end
  end
end
