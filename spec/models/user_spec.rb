require_relative '../spec_helper'

describe User do

  let :user do
    Fabricate.build :user
  end
  
  describe 'validation' do
    
    it 'wont validate blank username' do
      user.username = ''
      user.wont_be :valid?
    end
    
    it 'wont validate invalid username' do
      user.username = 'invalid'
      user.wont_be :valid?
    end
    
    it 'must validate valid username' do
      user.username = 'abc123'
      user.must_be :valid?
    end
    
  end
  
  describe 'authentication' do
    
    it 'wont authenticate with invalid credentials' do
      User.authenticate(ENV['LDAP_UID'], 'invalid').must_equal nil
    end
    
    it 'must authenticate with valid credentials' do
      User.authenticate(ENV['LDAP_UID'], ENV['LDAP_PASSWORD']).must_be_kind_of User
    end
    
  end
  
  describe 'entry' do
    
    it 'must return user displayname' do
      user.entry.displayname.must_include 'Jamie Milan Hodge'
    end
    
    it 'must return user title' do
      user.entry.title.must_include 'Akademisk medarbejder, Medieproducer'
    end
    
    it 'must return user departmentnumber' do
      user.entry.departmentnumber.must_include 'FLI; Itmedia'
    end
    
    it 'must return user mail' do
      user.entry.mail.must_include 'jamieh@hum.ku.dk'
    end
    
    it 'must return user employeetype' do
      user.entry.employeetype.must_include 'hum-fak'
    end
    
  end
  
end
