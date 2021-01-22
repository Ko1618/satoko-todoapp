class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.references :user, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.timestamps
    end
  end
end
