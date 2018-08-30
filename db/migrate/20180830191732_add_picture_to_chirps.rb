class AddPictureToChirps < ActiveRecord::Migration[5.2]
  def change
    add_column :chirps, :picture, :string
  end
end
