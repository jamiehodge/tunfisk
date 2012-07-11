module Store
  class Base
    include Enumerable
    
    def self.create path
      new path if FileUtils.mkdir_p path
    end
    
    def initialize path
      @path = path
    end
    
    def << id
      Bin.create File.join(@path, id.to_s)
    end
    
    def [] id
      Bin.new File.join(@path, id.to_s)
    end
    
    def each &block
      Dir.glob("#{@path}/*").collect { |path| Bin.new File.join(@path, path) }.each(&block)
    end
    
    def destroy
      FileUtils.rm_rf @path
    end
    
  end
end
