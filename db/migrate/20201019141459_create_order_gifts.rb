class CreateOrderGifts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_gifts do |t|
      t.references :order, null: false, foreign_key: true, comment: "What order to give away gift?"
      t.references :gift, null: false, foreign_key: true, comment: "Which gift are you ordering?"
      
      t.timestamps
    end
  end
end
