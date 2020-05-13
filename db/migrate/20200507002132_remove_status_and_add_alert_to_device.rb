class RemoveStatusAndAddAlertToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :in_alert, :boolean, default: false, null: false
    remove_column :devices, :active
  end
end
