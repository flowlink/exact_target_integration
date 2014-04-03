require "sinatra"
require "endpoint_base"

Dir['./lib/**/*.rb'].each(&method(:require))

class ExactTargetEndpoint < EndpointBase::Sinatra::Base 
  set :logging, true

  post '/send_email' do
    begin
      code = 200
      msg = Processor.process_email! @config, @payload
    rescue ExactTargetError => e
      code = 500
      msg = e.message
    rescue => e
      code = 500
      msg = e.message
    end

    result code, msg
  end
end
