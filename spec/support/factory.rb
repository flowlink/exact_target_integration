module Factory
  class << self

    def username
      '12345'
    end

    def password
      '12345'
    end

    def api_url
      'webservice.s6.exacttarget.com'
    end

    def config
      [
        { 'name' => 'username', 'value' => username },
        { 'name' => 'password', 'value' => password }
      ]
    end

    def processed_config
      { 
        'username' => username,
        'password' => password
      }
    end

    def payload args={}
      {
        :email => {
          :subject => "Hello World",
          :body => {
            :text => "Hello World body",
            :html => "<h1>Hello World</h1><br>body"
          },
          :to => "andrei@spreecommerce.com",
          :from => "andrei@spreecommerce.com",
          :cc => "andrei@spreecommerce.com",
          :bcc => "andrei@spreecommerce.com"
        }
      }.merge(args)
    end
  end
end