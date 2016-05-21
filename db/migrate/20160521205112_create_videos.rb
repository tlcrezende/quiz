class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.text :description
      t.string :url

      t.timestamps null: false
    end
  end
end
