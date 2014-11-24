class Notifier

  def self.send_notifications(notifications)
    notifications.each do |notification|
      params = Hash[notification.conditions.map{|condition| [condition.name, "1"]}]
      report = Report.new(notification.zip_code, params)
      if !report.health_effects?("today") || !report.health_effects?("tomorrow")
        if notification.email || notification.phone_number
          UserNotifier.send_notification_email(notification).deliver
          TextSender.send_text(notification.phone_number, "This is a message")
        elsif notification.email
          UserNotifier.send_notification_email(notification).deliver
        else
          TextSender.send_text(notification.phone_number, "This is a message")
        end
      end
    end
  end
end
