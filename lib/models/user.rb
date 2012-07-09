class User < Sequel::Model

  def validate
    super
    validates_presence :username
    validates_unique   :username
    validates_format   /^[a-z]{3}\d{3}$/, :username
  end
  
  def self.authenticate username, password
    new(username: username) if LDAP.authenticate username, password
  end
  
  def entry
    @entry ||= LDAP.first LDAP.filter(:uid, username)
  end
  
end
