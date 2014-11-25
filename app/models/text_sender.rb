class TextSender

  def self.send_notification_creation_text(notification)

    account_sid = Rails.application.secrets.account_sid
    auth_token = Rails.application.secrets.auth_token

    @client = Twilio::REST::Client.new account_sid, auth_token

    @client.account.messages.create({
      :from => '+17209033040',
      :to => notification.phone_number,
      :body => "Welcome to Monitor My Air. You will get notifications at this email address whenever current or forecasted
      air quality in zip code: #{notification.zip_code} is likely to aggravate these health conditions: #{notification.clean_conditions_message}"
    })
  end

  def self.send_notification_text(notification)

    account_sid = Rails.application.secrets.account_sid
    auth_token = Rails.application.secrets.auth_token

    @client = Twilio::REST::Client.new account_sid, auth_token

    @client.account.messages.create({
      :from => '+17209033040',
      :to => notification.phone_number,
      :body => "Monitor My Air Alert.  Current or Forecasted(tomorrow) air quality in zip code: #{notification.zip_code}is
      likely to aggravate these health conditions: #{notification.clean_conditions_message} Visit MonitorMyAir.org for more details"
      })
    end

end
