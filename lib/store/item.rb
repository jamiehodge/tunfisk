module Store
  class Item
    
    attr_reader :filename
    
    def self.create parent, path
      new parent, File.basename(path) if FileUtils.cp path, File.join(parent.path, File.basename(path))
    end
    
    def initialize parent, filename
      @parent = parent
      @filename = filename
    end
    
    def read
      File.open(path) {|f| f.read } if exist?
    end
    
    def << data
      data.rewind if data.respond_to? :rewind
      File.lock(path, 'a') {|f| f << data }
    end
    
    def destroy
      FileUtils.rm_f path
    end
    
    def path
      File.join @parent.path, filename
    end
    
    def to_s
      path
    end
    
    private
    
    def exist?
      File.file? path
    end
    
    def <=> other
      self.filename <=> other.filename
    end
    
  end
end