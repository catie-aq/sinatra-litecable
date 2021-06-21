# frozen_string_literal: true

require "sinatra"
require "sinatra/json"
require "sinatra/cookies"
require "haml"

CABLE_URL = ENV.fetch("CABLE_URL", "/cable")

class App < Sinatra::Application # :nodoc:

  ## Here set a custom public folder, or remove this to use ./public 
  # set :public_folder, File.dirname(__FILE__) + '/../suaave-viewer-app/build'

  ## Load index.htmd from external (React) app.
  get '/' do
    haml :index 
    # File.read(File.join(settings.public_folder, 'index.html'))
  end

end
