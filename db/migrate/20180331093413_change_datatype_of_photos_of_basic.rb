class ChangeDatatypeOfPhotosOfBasic < ActiveRecord::Migration[5.1]
  def change
  	change_column :basics, :id_front, :string
  	change_column :basics, :id_back, :string
  	change_column :basics, :company_certification, :string
  end
end
