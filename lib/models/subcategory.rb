class Subcategory < Sequel::Model

  many_to_one :category
  
  plugin :static_cache
  
  def validate
    super
    validates_presence [:category_id, :code, :name]
    validates_unique   [:category_id, :code]
    validates_not_string :code
    validates_length_range 1..255, :name
  end
end
