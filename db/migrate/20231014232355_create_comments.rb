class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.string :image, null: false
      
      t.belongs_to :recipe
      t.belongs_to :user


      t.timestamps
    end
  end
end
