class AddTestSetIdToTests < ActiveRecord::Migration
  def change
    add_column :tests, :test_set_id, :integer
  end
end
