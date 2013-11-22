class Processor

  def self.send_email! config, email_hash
    trigger = ETTriggeredSend.new(config)

    email = email_hash[:email]
    template = config[:template]
    attrs = generate_attrs(email_hash)

    # validate_email_hash!(email_hash)
    result = trigger.send!(template, email, attrs)

    if result && result["results"] && res["results"]["status_code"] == "OK"
      self.success_notification(email_hash[:to])
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

  def self.generate_attrs h
    {
      'Subject'=> 'Order Confirmation',
      'Email Address' => 'andrei.bondarev13@gmail.com',
      'First_Name' => 'John',
      'Last_Name' => 'Smith',
      'Order_Number' => '0123456789'
    }
  end

  def self.success_notification email
    { notifications:
      [
        {
          level: "info",
          subject: "Successfully sent an email to #{emails.join(', ')} via the Amazon Simple Email Service",
          description: "Successfully sent an email to #{emails.join(', ')} via the Amazon Simple Email Service"
        }
      ]
    }
  end

  def self.error_notification
    { notifications:
      [
        {
          level: "error",
          subject: "Successfully sent an email to #{emails.join(', ')} via the Amazon Simple Email Service",
          description: "Successfully sent an email to #{emails.join(', ')} via the Amazon Simple Email Service"
        }
      ]
    }
  end
end 