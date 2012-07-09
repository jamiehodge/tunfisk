class Keyword < Sequel::Model
  
  plugin :optimistic_locking
  
  def validate
    super
    validates_presence :name
    validates_unique   :name
    validates_length_range 1..255, :name
  end
  
  def_dataset_method(:text_search) do |query|
    return self if query.blank?
    full_text_search([:name], query.split.collect {|q| "#{q}:*"})
  end
  
end
