# frozen_string_literal: true

require "litecable"
# require "anycable"
require "redis"
require "yaml"
require "json"

## Hack to enable killing the server easily -> not required when launching directly puma.
interrupted = false
trap("INT") do 
   interrupted = true ; p "INTERRUPTED" 
   $threads.each { |t| Thread.kill(t) }
   exit
end

$threads = []

$config = YAML.load(
  File.open('./config/connection_redis.yaml').read
)

## Change the module name
module Ace

  class Connection < LiteCable::Connection::Base # :nodoc:
        identified_by :sid

        def connect
            #self.user = cookies["user"]
            self.sid = request.params["sid"]
            #reject_unauthorized_connection unless user
            $stdout.puts "someone connected: #{sid}"
        end

        def disconnect
          $stdout.puts "#{sid} disconnected"
        end
    end
    
    ### Channel Redis Rooms
    ## This channel connects to Redis, and does one get and subscribe to the same key.
    ## 
    class Channel < LiteCable::Channel::Base # :nodoc:
        identifier :ace

        def subscribed
             ## Here with key "ego", the client connects to channel "ace_ego" 
            reject unless key_id 
            @key_id = key_id
 
            stream_from "ace_#{@key_id}"
            p "Connection to stream: ace_#{key_id}"
        end

        def unsubscribed
            # stop_stream "ace_#{@key_id}"
            stop_all_streams
            p "Disconnection to stream: ace_#{key_id}"
        end

        private

        def key_id
          params.fetch("id")
        end
    end
end
