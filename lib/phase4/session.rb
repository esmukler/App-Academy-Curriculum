require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @cookie = {}
      req.cookies.each do |cook|
        if cook.name == '_rails_lite_app'
          @cookie = JSON.parse(cook.value)
          break
        end
      end
    end

    def [](key)
      @cookie[key]
    end

    def []=(key, val)
      @cookie[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      j = @cookie.to_json
      cook = WEBrick::Cookie.new('_rails_lite_app', j)
      res.cookies << cook
    end
  end
end
