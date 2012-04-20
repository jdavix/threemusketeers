class AddTwitterIdToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :twitter_id, :integer
  end
end
