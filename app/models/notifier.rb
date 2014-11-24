class Notifier

def self.send_notifications(notifications)
  notifications.each do |notification|
    params = Hash[notification.conditions.map{|condition| [condition.name, 1]}]
     notification.conditions.map do |notification|


  generate a report from this notification
  if there are alerts
    if there is an email address and phone number
      send email and text
    elsif there is an email address
      send email
    else
      send text
  end



  end

end
