class Notifier

  def self.send_notifications(notifications)
    notifications.each do |notification|
      params = Hash[notification.conditions.map{|condition| [condition.name, "1"]}]
      @report = Report.new(notification.zip_code, params)
      if self.alerts?
        self.send_notification(notification)
      end
    end
  end

  def self.alerts?
    !@report.health_effects?("today") || !@report.health_effects?("tomorrow")
  end

  def self.send_notification(notification)
    if notification.email && notification.phone_number
      UserNotifier.notification_email(notification, @report).deliver
      TextSender.send_notification_text(notification)
    elsif notification.email
      UserNotifier.notification_email(notification, @report).deliver
    else
      TextSender.send_notification_text(notification)
    end
  end

end
