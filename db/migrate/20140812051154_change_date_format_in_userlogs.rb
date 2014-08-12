class ChangeDateFormatInUserlogs < ActiveRecord::Migration
  def change
  	change_column :userlogs, :starttime, :datetime
  	change_column :userlogs, :endtime, :datetime
  end
end
