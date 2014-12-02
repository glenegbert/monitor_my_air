class NotificationsChangePhoneNumberType < ActiveRecord::Migration
  def change
    remove_column :notifications, :phone_number
    add_column :notifications, :phone_number, :bigint
  end
end
