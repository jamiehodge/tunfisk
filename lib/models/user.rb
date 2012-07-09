class User < Sequel::Model

  def validate
    super
    validates_presence :username
    validates_unique   :username
    validates_format   /^[a-z]{3}\d{3}$/, :username
  end
  
end
