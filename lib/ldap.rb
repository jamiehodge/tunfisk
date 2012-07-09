module LDAP
  extend self
  
  def authenticate uid, password
    ldap.bind_as base: base, filter: filter(:uid, uid), password: password
  end
  
  def first filter, &block
    search(filter, &block).first
  end
  
  def search filter, &block
    ldap.search base: base, filter: filter, &block
  end
    
  def ldap
    Net::LDAP.new host: host, port: port
  end
  
  def host
    ENV['LDAP_HOST']
  end
  
  def port
    ENV['LDAP_PORT']
  end
  
  def base
    ENV['LDAP_BASE']
  end
  
  def filter key, value
    Net::LDAP::Filter.eq key, value
  end
  
end
