class Asset < Sequel::Model
  
  many_to_one :item
  
  def validate
    super
    validates_presence [:name, :type, :size]
    validates_length_range 1..255, [:name, :type]
    validates_integer :size
    errors.add(:size, 'must be greater-than zero') unless size && size > 0
  end
  
  def_dataset_method(:text_search) do |query|
    return self if query.blank?
    full_text_search([:name], query.split.map {|q| "#{q}:*"})
  end
  
end
