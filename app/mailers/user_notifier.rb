class UserNotifier < ActionMailer::Base
  default from: "dopethreads5280@gmail.com"

  def send_notification_email(notification)
    @notification = notification
    mail( :to => @notification.email,
    :subject => 'This is a notification' )
  end
end
