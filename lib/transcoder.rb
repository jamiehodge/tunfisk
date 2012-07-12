require 'tempfile'

class Transcoder
  
  class << self
    attr_writer :formats
    
    def formats
      @formats ||= {}
    end
  end
  
  def self.format key, options
    formats[key] = options
  end
  
  def initialize(input, container=FFMPEG::Movie)
    @movie = container.new input
  end
  
  def transcode format
    Tempfile.open(['transcode', ".#{format}"]) do |output|
      
      @movie.transcode(output.path, options, self.class.formats[format]) do |progress|
        yield progress, output if block_given?
      end
    end
  end
  
  def screenshot
    Tempfile.open(['screenshot', image_extension]) do |output|
      @movie.screenshot(output.path, options, transcoder_options) do |progress|
        yield progress, output if block_given?
      end
    end
  end
  
  def image_extension
    '.png'
  end
  
  def options
    { resolution: '1080x1920' }
  end
  
  def transcoder_options
    { preserve_aspect_ratio: :width }
  end

end
