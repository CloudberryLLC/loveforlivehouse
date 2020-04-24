class AddConsumptionTaxToEstimation < ActiveRecord::Migration[5.1]
  def change
    add_column :estimations, :consumption_tax, :integer
  end
end
