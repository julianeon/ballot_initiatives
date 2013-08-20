class AddUserIdToInitiatives < ActiveRecord::Migration
  def change
  	add_column :initiatives, :user_id, :integer
  end
end
