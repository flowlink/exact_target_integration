require 'spec_helper'

describe ETTriggeredSend do
  let (:config) { Factory.processed_config }

  it 'creates valid object' do
    expect {
      instance = described_class.new(config)
      instance.sender.should be_kind_of(ExactTarget::TriggeredSend)
    }.to_not raise_error
  end
end
