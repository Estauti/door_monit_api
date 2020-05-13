class AddLastEmailSentAtToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :last_email_sent_at, :datetime
  end
end
