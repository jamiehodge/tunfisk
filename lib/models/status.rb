class Status < Sequel::Model
  
  one_to_many :approvals
  
  plugin :static_cache

  self.each do |status|
    const_set status.name.upcase, status
  end
  
  def validate
    super
    validates_presence :name
    validates_unique   :name
    validates_length_range 1..255, :name
  end
  
end
