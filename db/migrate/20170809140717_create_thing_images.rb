class CreateThingImages < ActiveRecord::Migration[5.0]
  def change
    create_table :thing_images do |t|
      t.references :image, foreign_key: true, null: false
      t.references :thing, foreign_key: true, null: false
      t.integer :priority, null: false, default: 5
      t.integer :creator_id, null: false

      t.timestamps null: false
    end
    add_index :thing_images, [:image_id, :thing_id], unique: true
  end
end
