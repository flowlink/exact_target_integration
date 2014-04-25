Dir['./lib/**/*.rb'].each(&method(:require))

class ExactTargetEndpoint < EndpointBase::Sinatra::Base
  set :logging, true

  Honeybadger.configure do |config|
    config.api_key = ENV['HONEYBADGER_KEY']
    config.environment_name = ENV['RACK_ENV']
  end

  post '/send_email' do
    msg = Processor.process_email! @config, @payload
    result 200, msg
  end
end
