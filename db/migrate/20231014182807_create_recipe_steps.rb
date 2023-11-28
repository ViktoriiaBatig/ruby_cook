class CreateRecipeSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_steps do |t|
      t.text :description
      t.integer :position, null: false
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
