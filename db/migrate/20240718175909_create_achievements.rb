class CreateAchievements < ActiveRecord::Migration[7.1]
  def change
    create_table :achievements do |t|
      t.integer :user_id
      t.string :badge
      t.text :description

      t.timestamps
    end
  end
end
