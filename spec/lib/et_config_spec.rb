require 'spec_helper'

describe ETConfig do
  let (:config) { Factory.processed_config }

  it 'creates valid object' do
    expect {
      instance = described_class.new(config)

      ExactTarget.configuration.username.should eq(instance.username)
      ExactTarget.configuration.password.should eq(instance.password)
      ExactTarget.configuration.server.should be_present
    }.to_not raise_error
  end

  it 'raises error when username is missing' do
    expect {
      config.delete('exact_target_username')
      instance = described_class.new(config)
    }.to raise_error AuthorizationError
  end

  it 'raises error when password is missing' do
    expect {
      config.delete('exact_target_password')
      instance = described_class.new(config)
    }.to raise_error AuthorizationError
  end  
end
