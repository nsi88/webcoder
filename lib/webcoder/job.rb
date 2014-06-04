module Webcoder
  class Job < Resource

    def self.create(params={}, options={})
      post("/jobs", params, options)
    end

    def self.list(options={})
      options = options.dup
      params  = { :page     => options.delete(:page) || 1,
                  :per_page => options.delete(:per_page) || 50,
                  :state    => options.delete(:state) }

      get("/jobs", merge_params(options, params))
    end

    def self.details(job_id, options={})
      get("/jobs/#{job_id}", options)
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
