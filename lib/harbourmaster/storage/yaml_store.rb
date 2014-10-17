require "yaml/store"

module Harbourmaster
  module Storage
    class YamlStore
      def initialize(database:)
        @store = YAML::Store.new Harbourmaster.root.join("data",
                                                        database + ".yml")
      end

      def put(repo, channel)
        @store.transaction do
          @store[repo] ||= []
          @store[repo] << channel unless @store[repo].include?(channel)
        end
      end

      def get(repo)
        channels = []
        @store.transaction do
          channels = @store[repo]
        end
        channels
      end

      def delete(repo, channel)
        puts repo
        @store.transaction do
          @store[repo] ||= []
          @store[repo] = @store[repo] - [channel]
        end
      end

      def all
        @store.transaction(true) do
          @store.roots.each_with_object({}) do |root, hash|
            hash[root] = @store.fetch(root)
            hash
          end
        end
      end
    end
  end
end
