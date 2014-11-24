class NotificationsController < ApplicationController

  def index
    @notifications = Notification.where(user_id: current_user.id)
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.create(notification_params)
    set_conditions(params)
    @notification.user_id = current_user.id
    @notification.save
    redirect_to notifications_path
  end

  def destroy
    notification = current_user.notifications.find(params[:id])
    notification.destroy
    redirect_to notifications_path
  end

  def update
    @notification = current_user.notifications.find(params[:id])
    @notifiation.update(notification_params)
    redirect_to notifications_path
  end

  def edit
    @notification = current_user.notifications.find(params[:id])
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
