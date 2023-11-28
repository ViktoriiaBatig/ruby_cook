class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :title, null: false, default: ""
      t.string :image, null: false, default: ""
      t.text :description, null: false, default: ""

      t.integer :parent_id
      t.timestamps
    end

    add_foreign_key :categories, :categories, column: :parent_id
  end
end
