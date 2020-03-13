class ChangeOpenAttributeName < ActiveRecord::Migration[5.2]
  def change
    rename_column :measurements, :open, :opened
  end
end
