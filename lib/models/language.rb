class Language < Sequel::Model

  plugin :static_cache
  
  def validate
    super
    validates_presence [:code, :name]
    validates_unique   [:code, :name]
    validates_exact_length 2, :code
    validates_length_range 1..255, :name
  end
  
end
