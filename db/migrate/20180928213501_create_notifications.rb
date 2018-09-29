class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
    	t.references :user, 	index: true
    	t.references :sender, index: true
    	t.references :chirp,	index: true
    	t.references :conversation, index: true
    	t.integer		 :identifier
    	t.string		 :n_type

    	t.boolean    :read, 	default: false

      t.timestamps
    end
    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :users, column: :sender
    add_foreign_key :notifications, :chirps
    add_foreign_key :notifications, :conversations
  end
end
