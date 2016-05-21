class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.text :description
      t.text :question
      t.text :alternative1
      t.text :alternative2
      t.text :alternative3
      t.text :alternative4
      t.text :answer
      t.references :video, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
