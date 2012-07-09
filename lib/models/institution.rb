class Institution < Sequel::Model
  
  plugin :static_cache
  
  def validate
    super
    validates_presence :name
    validates_unique   :name
    validates_length_range 1..255, :name
  end

end
