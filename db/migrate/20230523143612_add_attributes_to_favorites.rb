class AddAttributesToFavorites < ActiveRecord::Migration[7.0]
  def change
    add_column :favorites, :title, :string, null: false
  end
end
