class Item < Sequel::Model

  many_to_one :collection
  many_to_one :category
  many_to_one :subcategory
  
  plugin :association_pks
  plugin :touch
  
  many_to_many :keywords, after_add: :touch_timestamp, after_remove: :touch_timestamp
  many_to_many :authors, class: User, after_add: :touch_timestamp, after_remove: :touch_timestamp
  
  one_to_one :asset
  
  plugin :optimistic_locking
  
  def validate
    super
    validates_presence [:collection_id, :category_id, :subcategory_id, :title, :description, :explicit]
    validates_length_range 1..255, :title
    validates_not_string :explicit
  end
  
  def_dataset_method(:text_search) do |query|
    return self if query.blank?
    full_text_search([:title,:description], query.split.map {|q| "#{q}:*"})
  end
  
  def touch_timestamp
    touch
  end
end
