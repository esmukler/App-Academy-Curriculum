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
      @params = {}

      @params = @params.merge(route_params) unless route_params.nil?
      unless req.query_string.nil?
        req_qs = parse_www_encoded_form(req.query_string)
      end
      @params = @params.merge(req_qs) unless req_qs.nil?
      unless req.body.nil?
        req_body = parse_www_encoded_form(req.body)
      end
      @params = @params.merge(req_body) unless req_body.nil?
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
      final_hash = {}

      output = URI::decode_www_form(www_encoded_form)

      output.each do |pair|
        key_array = parse_key(pair[0])
        val = pair[1]
        current_level = final_hash

        key_array.each_with_index do |key, idx|
          if idx == key_array.count - 1
            current_level[key] = val
          elsif current_level[key]
            current_level = current_level[key]
          else
            current_level[key] = {}
            current_level = current_level[key]
          end
        end
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
