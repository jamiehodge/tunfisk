class License < Sequel::Model
  
  plugin :static_cache
  
  def validate
    super
    validates_presence [:code, :name]
    validates_unique   [:code, :name]
    validates_length_range 1..255, [:code, :name]
  end
  
end
