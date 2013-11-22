require './lib/amazon_ses_config'

class ETTriggeredSend < ETConfig
  attr_accessor :sender

  def initialize config
    ETConfig.new(config)
    @sender = ExactTarget::TriggeredSend.new
  end


  def send! template, email, attributes
    sender.send!(template, email, attributes)
  end
end
