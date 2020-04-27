module Actions
  class TimeTracker

    include Singleton

    attr_reader :enabled

    def initialize
      @enabled = %w[1 True true TRUE].include?(ENV['RAILS_TIME_TRACKER_ENABLED'])
    end

    def track(request:)
      start = Time.now
      yield
      stop = Time.now

      total = (stop - start) * 1_000
      store(request: request, total: total) if enabled
    end

    private

    def store(request:, total:)
      Trail.create(
        url: request.path,
        params: request.params,
        milliseconds: total
      )
    end

  end
end
