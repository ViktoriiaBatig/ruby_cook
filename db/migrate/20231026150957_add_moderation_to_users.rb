class AddModerationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :comment_moderation, :boolean, default: false
    add_column :users, :recipe_moderation, :boolean, default: false
  end
end
