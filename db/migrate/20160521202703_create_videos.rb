class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.text :description
      t.references :test, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
