require_relative 'spec_helper'

describe LDAP do
  
  describe 'authentication' do
    
    it 'wont authenticate invalid credentials' do
      LDAP.authenticate(ENV['LDAP_UID'], 'invalid').must_equal false
    end
    
    it 'must authenticate valid credentials' do
      LDAP.authenticate(ENV['LDAP_UID'], ENV['LDAP_PASSWORD']).first.must_be_kind_of Net::LDAP::Entry
    end
    
  end
  
  describe 'search' do
    
    describe 'uid' do
      
      it 'wont return non-existant entry' do
        LDAP.search(LDAP.filter(:uid, 'nobody')).must_be :empty?
      end
    
      it 'must return existant entry' do
        LDAP.first(LDAP.filter(:uid, ENV['LDAP_UID'])).must_be_kind_of Net::LDAP::Entry
      end
      
    end
    
    describe 'email' do
      
      it 'wont return non-existant entry' do
        LDAP.search(LDAP.filter(:mail, 'invalid')).must_be :empty?
      end
      
      it 'must return existant entry' do
        LDAP.first(LDAP.filter(:mail, ENV['LDAP_EMAIL'])).must_be_kind_of Net::LDAP::Entry
      end
    end
  
  end

end
