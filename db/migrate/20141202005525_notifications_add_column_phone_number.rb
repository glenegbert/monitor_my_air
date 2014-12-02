class NotificationsAddColumnPhoneNumber < ActiveRecord::Migration
  def change
    add_column :notifications, :phone_number, :string
  end
end
