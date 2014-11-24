class TextSender

  def self.test_text(phone_number, message)

    account_sid = Rails.application.secrets.account_sid
    auth_token = Rails.application.secrets.auth_token

    @client = Twilio::REST::Client.new account_sid, auth_token

    @client.account.messages.create({
      :from => '+17209033040',
      :to => phone_number,
      :body => message,
      })
  end

end
