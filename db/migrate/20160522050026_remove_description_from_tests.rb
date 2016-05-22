class RemoveDescriptionFromTests < ActiveRecord::Migration
  def change
    remove_column :tests, :description, :text
  end
end
