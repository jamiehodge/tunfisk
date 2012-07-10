class Proxy < Sequel::Model
  
  many_to_one :asset
  
  plugin :optimistic_locking
  
  def validate
    super
    validates_presence [:asset_id, :name, :type, :size]
    validates_length_range 1..255, [:name, :type]
    validates_integer :size
    validates_format /^[-\w.+]+\/[-\w.+]*$/, :type
    errors.add(:size, 'must be greater-than zero') unless size && size > 0
  end
end