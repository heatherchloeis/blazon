class AddBioAndBirthdateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :bio, 				:text
    add_column :users, :birthdate, 	:date
    add_column :users, :location,		:string
    add_column :users, :website,		:string
  end
end
