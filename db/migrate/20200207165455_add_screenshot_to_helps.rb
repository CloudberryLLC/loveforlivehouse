class AddScreenshotToHelps < ActiveRecord::Migration[5.2]
  def change
    add_column :helps, :screenshot, :string
  end
end
