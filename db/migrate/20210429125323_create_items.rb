class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :code
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
