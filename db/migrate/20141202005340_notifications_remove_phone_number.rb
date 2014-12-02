class NotificationsRemovePhoneNumber < ActiveRecord::Migration
  def change
    remove_column :notifications, :phone_number
  end
end
