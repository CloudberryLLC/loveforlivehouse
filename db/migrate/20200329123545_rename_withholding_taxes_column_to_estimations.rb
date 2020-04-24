class RenameWithholdingTaxesColumnToEstimations < ActiveRecord::Migration[5.2]
  def change
    rename_column :estimations, :withholding_taxes, :withholding_tax
  end
end
