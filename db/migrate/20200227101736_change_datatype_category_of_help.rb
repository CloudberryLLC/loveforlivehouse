class ChangeDatatypeCategoryOfHelp < ActiveRecord::Migration[5.2]
  def change
    #development
  	#change_column :helps, :category, :integer

    #production
  	change_column :helps, :category, 'integer USING CAST(category AS integer)'
  end
end
