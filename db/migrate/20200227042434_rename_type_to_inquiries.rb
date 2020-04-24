class RenameTypeToInquiries < ActiveRecord::Migration[5.2]
  def change
    rename_column :inquiries, :type, :category
  end
end
