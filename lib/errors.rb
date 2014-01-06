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
          # TODO Investigate which error keys get returned in different error scenarios
          description: "#{errors_hash['subscriber_failures'].try(:[], 'error_description') || errors_hash['status_message']} ",
          backtrace: self.backtrace.to_a.join('\n\t')
        }
      ]
    }
  end
end
