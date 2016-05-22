class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :access_token
      t.string :uid
      t.string :provider
      t.references :test_set, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
