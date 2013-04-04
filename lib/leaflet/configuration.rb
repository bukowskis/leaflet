require 'logger'

module Leaflet
  class Configuration

    attr_writer :default_per_page, :max_per_page

    def default_per_page
      Leaflet.positify {
        @default_per_page ||= 20
      }
    end

    def max_per_page
      Leaflet.positify {
        @max_per_page ||= 30
      }
    end

  end
end

module Leaflet

  # Public: Returns the the configuration instance.
  #
  def self.config
    @config ||= Configuration.new
  end

  # Public: Yields the configuration instance.
  #
  def self.configure(&block)
    yield config
  end

  # Public: Reset the configuration (useful for testing)
  #
  def self.reset!
    @config = nil
  end
end
