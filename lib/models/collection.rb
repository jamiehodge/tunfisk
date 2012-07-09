class Collection < Sequel::Model
  
  many_to_one :institution
  many_to_one :language
  many_to_one :license
  
  # plugin :association_pks
  # many_to_many :keywords
  
  plugin :instance_hooks
  plugin :optimistic_locking
  
  def validate
    super
    validates_presence [:institution_id, :language_id, :license_id, :title, :description, :department]
    validates_length_range 1..255, [:title, :department]
    validates_min_length 1, :description
  end
  
  def_dataset_method(:text_search) do |query|
    return self if query.blank?
    full_text_search([:title, :description, :department], query.split.map {|q| "#{q}:*"})
  end
  
end
