class AddEditingUserToInitiatives < ActiveRecord::Migration
  def change
  	add_column :initiatives, :last_edited_by, :integer
  end
end
