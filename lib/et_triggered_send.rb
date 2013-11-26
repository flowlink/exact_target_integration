require './lib/et_config'

class ETTriggeredSend
  attr_accessor :sender

  def initialize config
    ETConfig.new(config)
    @sender = ExactTarget::TriggeredSend.new
  end

  def send_email! template, email, attributes
    result = sender.send!(template, email, attributes)
    result["results"]
  end
end
