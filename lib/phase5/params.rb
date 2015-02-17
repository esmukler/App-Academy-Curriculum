require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = route_params
      unless req.query_string.nil?
        parse_www_encoded_form(req.query_string)
      end
    end

    def [](key)
      @params[key]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      final_hash = Hash.new { h[k] = {} }
      output = URI::decode_www_form(www_encoded_form)
      output.each do |tuple|
        key_array = parse_key(tuple[0])
        val = tuple[1]
        hashy = val
        key_array.count.times do |x|
          hashy = { key_array[-(x+1)] => hashy }
        end

        # => {"user"=>{"address"=>{"street"=>"main"}}}

        # => {"user"=>{"address"=>{"zip"=>"89436"}}}

      end
      final_hash
    end




    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end
  end
end
