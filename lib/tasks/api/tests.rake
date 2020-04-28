require 'net/http'
require 'parallel'

namespace :api do
  namespace :tests do

    desc 'Do request on top_ratings endpoint'
    task :top_ratings, %i[url times processors] => :environment do |_, args|
      args.with_defaults(times: 5_000, processors: 5)

      times = args.times.to_i
      processors = args.processors.to_i
      Parallel.each(times.times, in_processes: processors) do
        request_uri = URI.join(args.url, "/api/v1/top_ratings?limit=#{rand(1..550)}")
        send_request(uri: request_uri)
      end
    end

    desc 'Do request on authors endpoint'
    task :authors, %i[url times processors] => :environment do |_, args|
      args.with_defaults(times: 5_000, processors: 5)

      logins = User.pluck(:login)

      times = args.times.to_i
      processors = args.processors.to_i
      Parallel.each(times.times, in_processes: processors) do
        process_logins = logins.sample(rand(5..10))
        request_uri = URI.join(args.url, '/api/v1/authors')
        request_uri.query = "#{process_logins.map { |login| "logins[]=#{login}" }.join('&')}"
        send_request(uri: request_uri)
      end
    end

    private

    def send_request(uri:)
      Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.get(uri, 'Content-Type' => 'application/json')
      end
    end

  end
end
