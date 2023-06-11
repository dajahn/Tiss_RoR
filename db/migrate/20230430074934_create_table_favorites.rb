class CreateTableFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.string :objectId
      t.string :entryType
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
