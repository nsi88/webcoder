module Webcoder
  class Upload < Resource

    def self.create(params={}, options={})
      post("/uploads", params, options)
    end
  end
end