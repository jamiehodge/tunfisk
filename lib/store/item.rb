module Store
  class Item
    
    attr_reader :path
    
    def self.create file, path
      new path if FileUtils.cp file, path
    end
    
    def initialize path
      @path = path
    end
    
    def read
      File.open(@path) {|f| f.read } if exist?
    end
    
    def << data
      data.rewind if data.respond_to? :rewind
      File.lock(@path, 'a') {|f| f << data }
    end
    
    def destroy
      FileUtils.rm_f path
    end
    
    def filename
      File.basename path
    end
    
    private
    
    def exist?
      File.file? @path
    end
    
    def <=> other
      self.filename <=> other.filename
    end
    
  end
end