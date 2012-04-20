class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.datetime :twitter_created_at
      t.string :username
      t.text :content

      t.timestamps
    end
  end
end
