class CreateGifters < ActiveRecord::Migration[6.0]
  def change
    create_table :gifters do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, unique: true

      t.timestamps
    end

    add_index :gifters, :email, unique: true
  end
end
