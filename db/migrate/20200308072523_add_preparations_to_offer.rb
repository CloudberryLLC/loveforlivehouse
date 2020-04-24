class AddPreparationsToOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :description, :text
    add_column :offers, :equipments, :text
    add_column :offers, :rehearsal, :text
    add_column :offers, :carry_in, :text
    add_column :offers, :parking, :text
    add_column :offers, :dressing_room, :text
    add_column :offers, :stage, :text
    add_column :offers, :accommodation, :text
    add_column :offers, :other_condition, :text
  end
end
