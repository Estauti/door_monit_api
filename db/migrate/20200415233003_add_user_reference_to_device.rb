class AddUserReferenceToDevice < ActiveRecord::Migration[5.2]
  def change
    add_reference :devices, :user, foreign_key: true, default: User.first.id
  end
end
