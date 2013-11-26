require 'spec_helper'

describe ExactTargetEndpoint do

  let(:message) {
    {
      'store_id' => '123229227575e4645c000001',
      'message_id' => '123229227575e4645c000002',
      'message' => 'order:new',
      'payload' => Factory.payload.merge({:parameters => Factory.config}).merge(Factory.email)
    }
  }

  def app
    ExactTargetEndpoint
  end

  def auth
    {'HTTP_X_AUGURY_TOKEN' => 'x123', "CONTENT_TYPE" => "application/json"}
  end

  it "sends e-mail" do
    VCR.use_cassette('send_email_success') do
      post '/send_email', message.to_json, auth

      last_response.status.should eq(200)

      last_response.body.should match("message_id")
      last_response.body.should match("notifications")
      last_response.body.should match("info")
      last_response.body.should match("Successfully enqued an email")
    end
  end

  it "returns error notification for invalid e-mail" do
    VCR.use_cassette('send_email_fail') do
      message['payload'][:email][:to] = 'spree@example.com'

      post '/send_email', message.to_json, auth

      last_response.status.should eq(500)

      last_response.body.should match("message_id")
      last_response.body.should match("notifications")
      last_response.body.should match("error")
      last_response.body.should match("Subscriber was excluded by List Detective")
    end
  end

  it "raises InvalidArguments error when 'template' attribute is missing" do
    message['payload'][:email].delete(:template)

    post '/send_email', message.to_json, auth

    last_response.status.should eq(500)

    last_response.body.should match("message_id")
    last_response.body.should match("notifications")
    last_response.body.should match("error")
    last_response.body.should match("InvalidArguments")
    last_response.body.should match("'to', 'template', 'parameters' attributes are required")
  end

  it "raises InvalidArguments error when 'to' attribute is missing" do
    message['payload'][:email].delete(:to)

    post '/send_email', message.to_json, auth

    last_response.status.should eq(500)

    last_response.body.should match("message_id")
    last_response.body.should match("notifications")
    last_response.body.should match("error")
    last_response.body.should match("InvalidArguments")
    last_response.body.should match("'to', 'template', 'parameters' attributes are required")
  end
end
