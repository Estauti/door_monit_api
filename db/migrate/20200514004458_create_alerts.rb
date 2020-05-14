class CreateAlerts < ActiveRecord::Migration[5.2]
  def change
    create_table :alerts do |t|
      t.references :device, foreign_key: true
      t.datetime :started_at
      t.datetime :finished_at
    end
  end
end
