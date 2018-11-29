class CreateMentions < ActiveRecord::Migration[5.2]
  def change
    create_table :mentions do |t|

      t.timestamps
    end
  end
end
