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
    @new_notification = Notification.create(notification_params)
    new_notification_tasks(params)
    @notification = Notification.new
  end

  def destroy
    @notification = current_user.notifications.find(params[:id])
    @notification.destroy
  end

  def update
    @new_notification = current_user.notifications.find(params[:id])
    @new_notification.update(notification_params)
    set_conditions(params)
    @new_notification.save
    @notification = Notification.new
  end

  def edit
    @notification = current_user.notifications.find(params[:id])
  end

  private

  def notification_params
    params.require(:notification).permit(:name, :zip_code, :email, :phone_number)
  end

  def set_conditions(params)
    condition_ids = params["notification"]["conditions"][1..-1]
    @new_notification.conditions = condition_ids.map do |id|
      Condition.find(id)
    end
  end

  def send_welcome_messages
    if @new_notification.email.length > 0 && @new_notification.phone_number
      UserNotifier.delay.notification_creation_email(@new_notification)
      TextSender.delay.send_notification_creation_text(@new_notification)
    elsif @new_notification.email.length > 0
      UserNotifier.delay.notification_creation_email(@new_notification)
    else
      TextSender.delay.send_notification_creation_text(@new_notification)
    end
  end

  def new_notification_tasks(params)
    set_conditions(params)
    @new_notification.user_id = current_user.id
    @new_notification.save
    send_welcome_messages
  end
end
