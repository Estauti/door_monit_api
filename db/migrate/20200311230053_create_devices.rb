class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :mac, null: false
      t.string :name, null: false
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :devices, :mac, unique: true
  end
end
