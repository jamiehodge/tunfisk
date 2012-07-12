class Asset < Sequel::Model
  
  many_to_one :item
  
  one_to_many :proxies
  one_to_many :approvals
  
  def validate
    super
    validates_presence [:item_id, :name, :type, :size]
    validates_length_range 1..255, [:name, :type]
    validates_integer :size
    validates_format /^[-\w.+]+\/[-\w.+]*$/, :type
    errors.add(:size, 'must be greater-than zero') unless size && size > 0
  end
  
  def_dataset_method(:text_search) do |query|
    return self if query.blank?
    full_text_search([:name], query.split.map {|q| "#{q}:*"})
  end

end
