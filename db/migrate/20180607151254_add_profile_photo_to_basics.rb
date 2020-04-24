class AddProfilePhotoToBasics < ActiveRecord::Migration[5.1]
  def change
    add_column :basics, :profile_photo, :string
    add_column :basics, :cover_photo, :string
  end
end
