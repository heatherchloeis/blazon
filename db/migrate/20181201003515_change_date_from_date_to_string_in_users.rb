class ChangeDateFromDateToStringInUsers < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :birthdate, :string
  end
end
