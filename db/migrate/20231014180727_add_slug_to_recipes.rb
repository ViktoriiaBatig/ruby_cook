class AddSlugToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :slug, :string, default: nil
  end
end
