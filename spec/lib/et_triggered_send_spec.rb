require 'spec_helper'

describe ETTriggeredSend do
  let (:config) { Factory.processed_config }

  it 'creates valid object' do
    expect {
      instance = described_class.new(config)
      instance.sender.should be_kind_of(ExactTarget::TriggeredSend)
    }.to_not raise_error
  end

  it '#send_email! calls send! on the sender' do
    instance = described_class.new(config)
    instance.sender.should_receive(:send!).with(anything, anything, anything).once
    instance.send_email!(anything, anything, anything)
  end
end
