require './lib/errors'

class ETConfig
  attr_accessor :username, :password, :server

  def initialize config
    @username = config['exact_target.username']
    @password = config['exact_target.password']
    @server = config['exact_target.server'] || 'webservice.s6.exacttarget.com'

    validate!
    
    ExactTarget.configure do |config|
      config.username = @username
      config.password = @password
      config.server = @server
    end
  end

  private
  def validate!
    raise AuthorizationError, "ExactTarget username and password must be provided" if (username.blank? || password.blank?)
  end
end
