class DropWebsiteFromUsers < ActiveRecord::Migration[5.2]
  def up
  	remove_column :users, :website
  end
end
