class CreateUserlogs < ActiveRecord::Migration
  def change
    create_table :userlogs do |t|
      t.string :starttime
      t.string :endtime
      t.string :string

      t.timestamps
    end
  end
end
