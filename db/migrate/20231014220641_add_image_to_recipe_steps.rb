class AddImageToRecipeSteps < ActiveRecord::Migration[6.1]
  def change
    add_column :recipe_steps, :image, :string
  end
end
