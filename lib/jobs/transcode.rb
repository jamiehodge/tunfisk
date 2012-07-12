module Job
  class Transcode
    
    def self.enqueue(options)
      DefaultQueue.enqueue 'Job::Transcode.perform', options
    end
  
    def self.perform(options)
      new(options).perform
    end
  
    def initialize(transcoder=Transcoder, options)
      @transcoder = transcoder
      @asset_id   = options['asset_id']
      @input      = options['input']
    end
  
    def perform
      screen = @transcoder.new(@input).screenshot
      DB.transaction do
        Asset[@asset_id].add_proxy name: File.basename(screen), type: 'image/png', size: screen.size
        ProxyStore[@asset_id] << screen.path
      end
      
      mp4 = @transcoder.new(@input).transcode :mp4
      DB.transaction do
        Asset[@asset_id].add_proxy name: File.basename(mp4), type: 'video/mp4', size: mp4.size
        ProxyStore[@asset_id] << mp4.path
      end
      
      webm = @transcoder.new(@input).transcode :webm
      DB.transaction do
        Asset[@asset_id].add_proxy name: File.basename(webm), type: 'video/webm', size: webm.size
        ProxyStore[@asset_id] << webm.path
      end
    end
    
  end
  
end
