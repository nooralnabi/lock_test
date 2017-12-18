class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name
      t.boolean :busy, default: false

      t.timestamps
    end
  end
end
