# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'ostruct'
require 'net/http'
require 'parallel'

class Seeder

  BATCH = 1_000

  attr_reader :counts, :processors, :url

  def initialize(counts: nil, processors: 5, url: nil)
    @counts = OpenStruct.new(counts || default_counts)
    @processors = processors
    @url = url
  end

  def generate
    logins = (1..counts[:users]).map { |number| "login_#{number}" }
    ips = (1..counts[:ips]).map { ip_v4_address }

    Parallel.each((counts[:posts] / BATCH).times, in_processes: processors) do |step|
      BATCH.times do |index|
        number = step * BATCH + index
        attributes = {
          title: "Title #{number}", content: "Content #{number}",
          login: logins.sample, ip: ips.sample
        }

        if url
          request_uri = URI.join(url, '/api/v1/posts')
          send_request(uri: request_uri, data: { post: attributes })
        else
          Posts::Creator.new(attributes: attributes).create
        end
      end
    end
  end

  private

  def default_counts
    { users: 100, posts: 1_000_000, ips: 50 }
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

Seeder.new.generate
