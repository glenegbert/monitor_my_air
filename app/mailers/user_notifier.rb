class UserNotifier < ActionMailer::Base
  default from: "glenegbert1@gmail.com"

  def notification_creation_email(notification)
    @notification = notification
    mail( :to => @notification.email,
    :subject => 'You Have Created a Monitor My Air Notification' )
  end

  def notification_email(notification, report)
    @notification = notification
    @report = report
    mail( :to => @notification.email,
    :subject => 'Notification From MonitorMyAir.org' )
  end
end
