class AddReferenceIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :reference_id, :integer
    add_index  :posts, :reference_id
  end
end
