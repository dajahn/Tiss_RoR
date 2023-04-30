class Augments < ActiveRecord::Migration[7.0]
  def change
    add_column :favorites, :keywords, :string, null: true
    add_column :favorites, :notes, :string, null: true
  end
end
