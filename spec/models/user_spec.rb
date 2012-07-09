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
  
end
