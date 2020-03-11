class AddAuthorizedToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :authorized, :boolean, default: false
  end
end
