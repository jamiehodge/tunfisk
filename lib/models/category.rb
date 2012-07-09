class Category < Sequel::Model

  one_to_many :subcategories
  
  plugin :static_cache
  
  def validate
    super
    validates_presence [:code, :name]
    validates_unique   :code
    validates_not_string :code
    validates_length_range 1..255, :name
  end
end
