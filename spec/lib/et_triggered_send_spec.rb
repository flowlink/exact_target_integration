require 'spec_helper'

describe ETTriggeredSend do
  let (:config) { Factory.processed_config }

  it 'creates valid object' do
    expect {
      instance = described_class.new(config)
      instance.sender.should be_kind_of(ExactTarget::TriggeredSend)
    }.to_not raise_error
  end

  it 'send_email! succeeds with valid parameters' do
    VCR.use_cassette('send_email_success') do
      instance = described_class.new(config)
      ret = instance.send_email! 'sample_order', 'andrei@spreecommerce.com', Factory.email[:email][:parameters]

      ret.should be_kind_of(Hash)
      ret['status_code'].should eq('OK')
    end
  end

  it 'send_email! fails with invalid e-mail' do
    VCR.use_cassette('send_email_fail') do
      instance = described_class.new(config)
      ret = instance.send_email! 'sample_order', 'spree@example.com', Factory.email[:email][:parameters]

      ret.should be_kind_of(Hash)
      ret['status_code'].should eq('Error')
    end
  end
end