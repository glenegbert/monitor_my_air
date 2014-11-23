class NotificationsController < ApplicationController

  def index
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.create(notification_params)
    set_conditions(params)
    redirect_to notifications_path
  end

  private

  def notification_params
    params.require(:notification).permit(:name, :zip_code, :email, :phone_number)
  end

  def set_conditions(params)
    condition_ids = params["notification"]["condition_ids"][1..-1]
    @notification.conditions = condition_ids.map do |id|
      Condition.find(id)
    end
  end
end
