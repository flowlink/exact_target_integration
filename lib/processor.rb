class Processor

  def self.process_email! config, payload
    trigger = ETTriggeredSend.new(config)

    template = payload[:email][:template]
    email, attrs = build_attributes(payload)

    # validate_email_hash!(email_hash)
    result = trigger.send_email!(template, email, attrs)

    if result && result["results"] && result["results"]["status_code"] == "OK"
      self.success_notification(email)
    else
      self.error_notification
    end
  end

  private
  # def self.validate_email_hash! h
  #   if h[:to].blank? || h[:from].blank? || h[:subject].blank? || h[:body].blank?
  #     raise InvalidArguments, "'to', 'from', 'subject', 'body' attributes are required"
  #   end
  # end

  def self.build_attributes payload
    email = payload[:email] && payload[:email][:to] || 'andrei.bondarev13@gmail.com'
    attrs = 
      {
        'Subject'=> 'Order Confirmation',
        'First_Name' => 'John',
        'Last_Name' => 'Smith',
        'Order_Number' => '0123456789'
      }
    [email, attrs]
  end

  def self.success_notification email
    { notifications:
      [
        {
          level: "info",
          subject: "Successfully enqued an email to #{email} via ExactTarget",
          description: "Successfully enqued an email to #{email} via ExactTarget"
        }
      ]
    }
  end

  def self.error_notification
    { notifications:
      [
        {
          level: "error",
          subject: "Successfully sent an email to via the Amazon Simple Email Service",
          description: "Successfully sent an email to via the Amazon Simple Email Service"
        }
      ]
    }
  end
end 