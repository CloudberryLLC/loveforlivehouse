class AddOwnerInfoToPerformerProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :performer_profiles, :zipcode, :string
    add_column :performer_profiles, :pref, :string
    add_column :performer_profiles, :city, :string
    add_column :performer_profiles, :street, :string
    add_column :performer_profiles, :bldg, :string
    add_column :performer_profiles, :shop_email, :string
    add_column :performer_profiles, :shop_phone, :string
    add_column :performer_profiles, :shop_url, :string
    add_column :performer_profiles, :company, :string
    add_column :performer_profiles, :owner, :string
    add_column :performer_profiles, :manager, :string
  end
end
