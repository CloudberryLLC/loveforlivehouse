class ChangeDatatypeCategoryOfHelp < ActiveRecord::Migration[5.2]
  def change
  	change_column :helps, :category, 'integer USING CAST(category AS integer)'
  end
end
