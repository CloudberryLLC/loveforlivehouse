class AddSetOfInstrumentsToPerformerProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :performer_profiles, :set_of_instruments, :string
  end
end
