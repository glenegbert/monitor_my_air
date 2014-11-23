class NotificationsController < ApplicationController

  def index
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.create(params)
  end

  private

  def notifiation_params
  end

end
