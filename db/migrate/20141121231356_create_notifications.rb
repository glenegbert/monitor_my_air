class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.string :name
      t.integer :zip_code
      t.string :email
      t.integer :phone_number

      t.timestamps
    end
  end
end
