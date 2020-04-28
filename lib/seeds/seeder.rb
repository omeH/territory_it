require 'ostruct'
require 'net/http'
require 'parallel'

module Seeds
  class Seeder

    BATCH = 1_000

    attr_reader :counts, :processes, :url

    def initialize(counts: nil, processes: 5, url: nil)
      @counts = OpenStruct.new(default_counts.merge(Hash(counts)))
      @processes = processes
      @url = url
    end

    def generate
      logins = (1..counts.users).map { "login_#{rand(10_000)}" }
      ips = (1..counts.ips).map { ip_v4_address }

      Parallel.each((counts.posts / BATCH).times, in_processes: processes) do |step|
        BATCH.times do |index|
          number = step * BATCH + index
          attributes = {
            title: "Title #{number}", content: "Content #{number}",
            login: logins.sample, ip: ips.sample
          }

          if url.present?
            request_uri = URI.join(url, '/api/v1/posts')
            send_request(uri: request_uri, data: { attributes: attributes })
          else
            Posts::Creator.new(attributes: attributes).create
          end
        end
      end

      part = 100 # Part of posts with rating
      post_ids_for_rating = Post.where('id % ? = 0', part).ids

      post_ids_for_rating.each do |post_id|
        tries_count = processes * 3
        Parallel.each(tries_count.times, in_processes: processes) do
          value = rand(Ratings::Calculator::MIN_RATING..Ratings::Calculator::MAX_RATING)

          if url.present?
            request_uri = URI.join(url, "/api/v1/ratings/#{post_id}")
            send_request(uri: request_uri, method: :put, data: { value: value })
          else
            Ratings::Updater.new(post_id: post_id, value: value).update
          end
        end
      end
    end

    private

    def default_counts
      { users: 100, posts: 200_000, ips: 50 }
    end

    def ip_v4_address
      range = 0..255
      [rand(range), rand(range), rand(range), rand(range)].join('.')
    end

    def send_request(uri:, method: :post, data: {})
      Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.public_send(method, uri, data.to_json, 'Content-Type' => 'application/json')
      end
    end

  end
end
