class UserNotifier < ActionMailer::Base
  default from: "glenegbert1@gmail.com"

  def notification_creation_email(notification)
    @notification = notification
    mail( :to => @notification.email,
    :subject => 'Welcome to Monitor My Air' )
  end

  def send_notification_email(notification)
    @notification = notification
    mail( :to => @notification.email,
    :subject => 'This is a notification' )
  end
end
