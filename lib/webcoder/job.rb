module Webcoder
  class Job < Resource

    def self.create(params={}, options={})
      post("/jobs", params, options)
    end

    def self.index(params={}, options={})
      get('/jobs?' + URI.encode(params.map { |k,v| "#{k}=#{v}" }.join("&")), options)
    end

    def self.show(job_id, options={})
      get("/jobs/#{job_id}", options)
    end    

    def self.update(params={}, options={})
      put("/jobs/#{params.delete(:id)}", { :job => params }, options)
    end

    def self.pause(job_id, options={})
      post("/jobs/#{job_id}/pause", nil, options)
    end

    def self.resume(job_id, options={})
      post("/jobs/#{job_id}/resume", nil, options)
    end

    def self.destroy(job_id, options={})
      delete("/jobs/#{job_id}", options)
    end
  end
end
