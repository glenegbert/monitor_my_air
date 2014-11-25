class NotificationsController < ApplicationController
  respond_to :html, :js

  def index
    @notifications = Notification.where(user_id: current_user.id)
    @notification = Notification.new
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.create(notification_params)
    set_conditions(params)
    @notification.user_id = current_user.id
    @notification.save
    if @notification.email.length > 0 && @notification.phone_number
      UserNotifier.notification_creation_email(@notification).deliver
      TextSender.send_notification_creation_text(@notification)
    elsif @notification.email.length > 0
      UserNotifier.notification_creation_email(@notification).deliver
    else
      TextSender.send_notification_creation_text(@notification)
    end
  end

  def destroy
    notification = current_user.notifications.find(params[:id])
    notification.destroy
    redirect_to notifications_path
  end

  def update
    @notification = current_user.notifications.find(params[:id])
    @notification.update(notification_params)
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
