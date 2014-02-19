module Webcoder
  class User < Resource

    def self.create(params={}, options={})
      params[:id] = params.delete(:api_key) if params[:api_key]
      post("/users", params, options)
    end

    def self.destroy(api_key, options = {})
      delete("/users/#{api_key}", options)
    end
  end
end