require 'net/http'
require 'uri'

module Job
  class Ping
    
    URL = 'http://deimos.apple.com/WebObjects/Core.woa/PingPodcast'
    
    def self.enqueue(options)
      DefaultQueue.enqueue 'Job::Ping.perform', options
    end
    
    def self.perform(options)
      new(options).perform
    end
    
    def initialize(client=Net::HTTP, options)
      @client = client
      @url = options['url']
    end
    
    def perform
      @client.get_response "#{uri}?feedURL=#{@url}"
    end
    
    private
    
    def uri
      URI.parse URL
    end
  end
end
