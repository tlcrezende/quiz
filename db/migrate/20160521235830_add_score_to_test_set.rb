class AddScoreToTestSet < ActiveRecord::Migration
  def change
    add_column :test_sets, :score, :integer
  end
end
