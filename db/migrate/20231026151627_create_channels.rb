class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.string :youtube_id, default: ''
      t.timestamps
    end
  end
end
