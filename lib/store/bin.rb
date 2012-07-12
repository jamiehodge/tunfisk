module Store
  class Bin
    include Enumerable
    
    def self.create parent, id
      new parent, id if FileUtils.mkdir_p File.join(parent.path, id.to_s)
    end
    
    def initialize parent, id
      @parent = parent
      @id = id
    end
    
    def << file
      save unless exist?
      Item.create self, file
    end
    
    def [] filename
      Item.new self, filename
    end
    
    def each &block
      Dir.glob("#{path}/*").collect { |path| Item.new self, File.basename(path) }.each(&block)
    end
    
    def save
      FileUtils.mkdir_p path
    end
    
    def destroy
      FileUtils.rm_rf path
    end
    
    def path
      File.join @parent.path, @id.to_s
    end
    
    def to_s
      path
    end
    
    private
    
    def exist?
      File.directory? path
    end
    
  end
end
