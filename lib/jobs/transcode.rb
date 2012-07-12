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
      File.open screen.path, 'r' do |f|
        Asset[@asset_id].add_proxy tempfile: f, type: 'image/png'
      end
      
      mp4 = @transcoder.new(@input).transcode :mp4
      File.open mp4.path, 'r' do |f|
        Asset[@asset_id].add_proxy tempfile: f, type: 'video/mp4'
      end
      
      webm = @transcoder.new(@input).transcode :webm
      File.open webm.path, 'r' do |f|
        Asset[@asset_id].add_proxy tempfile: f, type: 'video/webm'
      end
    end
  end
end
