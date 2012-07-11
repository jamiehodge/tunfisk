module Store
  class Bin
    include Enumerable
    
    def self.create path
      new path if FileUtils.mkdir_p path
    end
    
    def initialize path
      @path = path
    end
    
    def << file
      save unless exist?
      Item.create file, File.join(@path, File.basename(file))
    end
    
    def [] filename
      Item.new File.join(@path, filename)
    end
    
    def each &block
      Dir.glob("#{@path}/*").collect { |path| Item.new File.join(@path, path) }.each(&block)
    end
    
    def save
      FileUtils.mkdir_p @path
    end
    
    def destroy
      FileUtils.rm_rf @path
    end
    
    private
    
    def exist?
      File.directory? @path
    end
    
  end
end
