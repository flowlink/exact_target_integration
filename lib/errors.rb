class AuthorizationError < StandardError; end
class InvalidArguments < StandardError; end

class ExactTargetError < StandardError
  attr_accessor :errors_hash
  
  def initialize errors_hash
    @errors_hash = errors_hash
  end

  def generate_error_notification
    { notifications:
      [
        {
          level: 'error',
          subject: "#{self.class}: #{errors_hash['error_code']} -- #{errors_hash['status_message']}",
          description: "#{errors_hash['subscriber_failures']['error_description']}",
          backtrace: self.backtrace.to_a.join('\n\t')
        }
      ]
    }
  end
end
