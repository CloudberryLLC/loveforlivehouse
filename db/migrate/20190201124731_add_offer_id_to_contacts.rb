class AddOfferIdToContacts < ActiveRecord::Migration[5.2]
  def change
    add_reference :contacts, :offer, foreign_key: true
  end
end
