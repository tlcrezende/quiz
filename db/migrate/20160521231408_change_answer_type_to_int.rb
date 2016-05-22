class ChangeAnswerTypeToInt < ActiveRecord::Migration
  def up
    change_column :tests, :answer, :int
  end

  def down
    change_column :tests, :answer, :text
  end
end
