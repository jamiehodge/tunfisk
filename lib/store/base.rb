module Store
  class Base
    include Enumerable
    
    attr_reader :path
    
    def self.create path
      new path if FileUtils.mkdir_p path
    end
    
    def initialize path
      @path = path
    end
    
    def << id
      Bin.create self, id
    end
    
    def [] id
      Bin.new self, id
    end
    
    def each &block
      Dir.glob("#{@path}/*").collect { |path| Bin.new self, File.basename(path) }.each(&block)
    end
    
    def destroy
      FileUtils.rm_rf @path
    end
    
    def to_s
      path
    end
    
  end
end
