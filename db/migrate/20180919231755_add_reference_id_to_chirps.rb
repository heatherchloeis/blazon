class AddReferenceIdToChirps < ActiveRecord::Migration[5.2]
  def change
    add_column :chirps, :reference_id, :integer
    add_index  :chirps, :reference_id
  end
end
