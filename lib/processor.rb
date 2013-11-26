class Processor

  def self.process_email! config, payload
    trigger = ETTriggeredSend.new(config)

    validate_email_hash!(payload[:email])

    template    = payload[:email][:template]
    email       = payload[:email][:to]
    parameters  = payload[:email][:parameters]

    result = trigger.send_email!(template, email, parameters)

    if result && result["status_code"] == "OK"
      self.success_notification(email)
    elsif result && result["status_code"] == "Error"
      raise ExactTargetError.new(result)
    end
  end

  private
  def self.validate_email_hash! h
    if h[:to].blank? || h[:template].blank? || h[:parameters].blank?
      raise InvalidArguments, "'to', 'template', 'parameters' attributes are required"
    end
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
end 