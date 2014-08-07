class AddPageIdToUserlog < ActiveRecord::Migration
  def change
    add_column :userlogs, :page_id, :integer
  end
end
