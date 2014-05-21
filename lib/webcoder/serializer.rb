class Hash
  def flatten_keys(newhash={}, keys=nil)
    self.each do |k, v|
      k = k.to_s
      keys2 = keys ? keys+"[#{k}]" : k
      if v.is_a?(Hash)
        v.flatten_keys(newhash, keys2)
      else
        newhash[keys2] = v
      end
    end
    newhash
  end
end

module Webcoder
  module Serializer

    extend self

    def self.included(klass)
      klass.extend(self)
    end

    def self.prepare_to_set_form(hash)
      normalize_params(hash)
    end

    def encode(content)
      if content.is_a?(String) || content.nil?
        content
      else
        if MultiJson.respond_to?(:dump)
          MultiJson.dump(content)
        else
          MultiJson.encode(content)
        end
      end
    end

    def decode(content)
      if content.is_a?(String)
        if MultiJson.respond_to?(:dump)
          MultiJson.load(content)
        else
          MultiJson.decode(content)
        end
      else
        content
      end
    end

    def normalize_params(params, key=nil)
      params = params.flatten_keys if params.is_a?(Hash)
      result = {}
      params.each do |k,v|
        case v
          when Hash
            result[k.to_s] = normalize_params(v)
          when Array
            v.each_with_index do |val,i|
            result["#{k.to_s}[#{i}]"] = val
          end
        else
          result[k.to_s] = v
        end
      end
      result
    end
  end
end
