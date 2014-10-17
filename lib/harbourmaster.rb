require_relative "harbourmaster/server"
require_relative "harbourmaster/storage/yaml_store"
require "pathname"

module Harbourmaster
  def self.root
    @root ||= Pathname.new(__FILE__).join("..").dirname
  end

  def self.store
    @store ||= Storage::YamlStore.new(database: "channels")
  end
end
