class CreateGifts < ActiveRecord::Migration[6.0]
  def change
    create_table :gifts do |t|
      t.references :product, null: false, foreign_key: true, comment: "What product is this order for?"
      t.references :child, null: false, foreign_key: true, comment: "Which child is this for?"
      t.references :gifter, null: false, foreign_key: true, comment: "Which gifter is sending the gift?"

      t.text :message, optional: true

      t.timestamps
    end
  end
end
