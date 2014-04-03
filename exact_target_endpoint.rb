require "sinatra"
require "endpoint_base"

Dir['./lib/**/*.rb'].each(&method(:require))

class ExactTargetEndpoint < EndpointBase::Sinatra::Base 
  set :logging, true

  post '/send_email' do
    begin
      code = 200
      msg = Processor.process_email! @config, payload
    rescue ExactTargetError => e
      code = 500
      msg = e.generate_error_notification
    rescue => e
      code = 500
      msg = standard_error_notification(e)
    end
    process_result code, base_msg.merge(msg)
  end

  private
  def payload
    @message[:payload]
  end

  def message_id
    @message[:message_id]
  end

  def base_msg
    { 
      'message_id' => message_id
    }
  end

  def standard_error_notification e
    { notifications:
      [
        {
          level: 'error',
          subject: "#{e.class}: #{e.message.strip}",
          description: "#{e.class}: #{e.message.strip}",
          backtrace: e.backtrace.to_a.join('\n\t')
        }
      ]
    }
  end
end
