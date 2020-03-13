class CreateMeasurements < ActiveRecord::Migration[5.2]
  def change
    create_table :measurements do |t|
      t.boolean :open, default: false
      t.references :device, foreign_key: true, null: false

      t.timestamps
    end
  end
end
