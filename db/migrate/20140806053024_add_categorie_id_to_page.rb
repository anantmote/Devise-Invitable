class AddCategorieIdToPage < ActiveRecord::Migration
  def change
    add_column :pages, :categorie_id, :integer
  end
end
