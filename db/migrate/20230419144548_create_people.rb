class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people, :id => false do |t|
      t.primary_key :id

      t.timestamps
    end
  end
end
