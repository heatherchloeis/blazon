class AddAncestryToChirps < ActiveRecord::Migration[5.2]
  def change
    add_column :chirps, :ancestry, :string
    add_index  :chirps, :ancestry
  end
end
