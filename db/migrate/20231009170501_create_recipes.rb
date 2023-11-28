class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :title, null: false, default: ""
      t.text :description, null: false, default: ""

      t.text :ingredients, null: false, default: ""
      t.string :image, null: false, default: ""
      t.integer :status, null: false, default: 0 # 0 - draft, 1 - moderation, 2 - published
      t.integer :views, null: false, default: 0
      
      t.integer :likes, null: false, default: 0
      t.integer :dislikes, null: false, default: 0
      t.integer :favorites, null: false, default: 0

      t.belongs_to :category, null: false, foreign_key: true

      t.belongs_to :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
