class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.integer :item_id
      t.references :cart, null: false, foreign_key: true

      t.timestamps
    end
  end
end
