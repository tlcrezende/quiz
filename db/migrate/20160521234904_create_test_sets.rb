class CreateTestSets < ActiveRecord::Migration
  def change
    create_table :test_sets do |t|
      t.text :description
      t.string :video_url

      t.timestamps null: false
    end
  end
end
