class CreateConditionsNotifications < ActiveRecord::Migration
  def change
      create_table :conditions_notifications, id: false do |t|
        t.belongs_to :condition
        t.belongs_to :notification
      end
  end
end
