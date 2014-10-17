require "sinatra/base"
require "sinatra/json"
require "rest-client"

require "json"

module Harbourmaster
  class Server < Sinatra::Base
    helpers Sinatra::JSON

    post "/docker-hub" do
      data = JSON.parse request.body.read
      repo_url = data["repository"]["repo_url"]
      repo_name = data["repository"]["repo_name"]

      channels = Harbourmaster.store.get(repo_name) || []
      channels.each do |channel|
        RestClient.post channel, payload: {
          text: %(Build finished: <#{repo_url}|#{repo_name}>),
          username: "Bot the builder",
          icon_emoji: ":wrench:"
        }.to_json
      end
    end

    get "/slack/channels" do
      json Harbourmaster.store.all
    end
    post "/slack/channels" do
      Harbourmaster.store.put(params["repo"], params["channel"])
    end
    delete "/slack/channels" do
      Harbourmaster.store.delete(params["repo"], params["channel"])
    end
  end
end
