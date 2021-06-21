# frozen_string_literal: true
require 'rack/cors'

# require_relative "config/environment.rb"

## Require manually 
require_relative "./app"
require_relative "./ace"

# LiteCable.config.log_level = Logger::DEBUG

use Rack::Cors, debug: true, logger: Logger.new(STDOUT) do

  allow do
    origins '*'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end


app = Rack::Builder.new do
  map "/" do
    run App
  end

  require "lite_cable/server"

  map "/cable" do

    use LiteCable::Server::Middleware, connection_class: Ace::Connection
    run(proc { |_| [200, {"Content-Type" => "text/plain"}, ["OK"]] })
  end
end

# unless ENV["ANYCABLE"]
#   # Start built-in rack hijack middleware to serve websockets
#   require "lite_cable/server"
#   app.map "/cable" do
#     use LiteCable::Server::Middleware, connection_class: RedisRooms::Connection
#     run(proc { |_| [200, {"Content-Type" => "text/plain"}, ["OK"]] })
#   end
# end


run app