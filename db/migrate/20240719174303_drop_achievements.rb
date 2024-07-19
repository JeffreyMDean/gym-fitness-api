class DropAchievements < ActiveRecord::Migration[7.1]
  def change
    drop_table :achievements
  end
end
