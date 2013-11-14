module Factory
  class << self

    def access_key_id
      '12345'
    end

    def secret_access_key
      '12345'
    end

    def config
      [
        { 'name' => 'access_key_id', 'value' => access_key_id },
        { 'name' => 'secret_access_key', 'value' => secret_access_key }
      ]
    end

    def processed_config
      { 
        'access_key_id' => access_key_id,
        'secret_access_key' => secret_access_key
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