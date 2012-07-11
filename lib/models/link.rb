class Link < Sequel::Model
  
  plugin :optimistic_locking
  
  def validate
    super
    validates_presence [:name, :url]
    validates_unique   :url
    validates_length_range 1..255, :name
    validates_format /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/, :url
  end
  
  def_dataset_method(:text_search) do |query|
    return self if query.blank?
    full_text_search([:name, :url], query.split.collect {|q| "#{q}:*"})
  end
  
end


