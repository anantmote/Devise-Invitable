class AddTimespentToUserlogs < ActiveRecord::Migration
  def change
    add_column :userlogs, :timespent, :integer
  end
end
