class AddUserIdToUserlog < ActiveRecord::Migration
  def change
    add_column :userlogs, :user_id, :integer
  end
end
