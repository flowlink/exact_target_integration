require 'spec_helper'

describe ExactTargetEndpoint do
  let(:message) {
    Factory.payload.merge({:parameters => Factory.config}).merge(Factory.email)
  }

  def app
    ExactTargetEndpoint
  end

  it "sends e-mail" do
    VCR.use_cassette('send_email_success') do
      post '/send_email', message.to_json, auth

      last_response.status.should eq(200)
      expect(json_response[:summary]).to match("Successfully enqued an email")
    end
  end

  it "returns error notification for invalid e-mail" do
    message[:email][:to] = 'spree@example.com'

    VCR.use_cassette('send_email_fail') do
      post '/send_email', message.to_json, auth

      last_response.status.should eq(500)
      expect(json_response[:summary]).to match("Subscriber was excluded by List Detective")
    end
  end

  it "raises InvalidArguments error when 'template' attribute is missing" do
    message[:email].delete(:template)
    post '/send_email', message.to_json, auth

    last_response.status.should eq(500)
    expect(json_response[:summary]).to match("'to', 'template', 'subject', 'variables' attributes are required")
  end

  it "raises InvalidArguments error when 'to' attribute is missing" do
    message[:email].delete(:to)
    post '/send_email', message.to_json, auth

    last_response.status.should eq(500)
    expect(json_response[:summary]).to match("'to', 'template', 'subject', 'variables' attributes are required")
  end
end
