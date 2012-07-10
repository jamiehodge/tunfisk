require_relative '../spec_helper'

describe Proxy do
  
  let :proxy do
    Fabricate :proxy
  end
  
  describe 'validation' do
      
    it 'must accept valid' do
      proxy.must_be :valid?
    end
    
    describe 'name' do
      
      it 'wont accept blank' do
        proxy.name = ''
        proxy.wont_be :valid?
      end
      
      it 'wont accept too long' do
        proxy.name = '*'*256
        proxy.wont_be :valid?
      end
      
    end
   
    describe 'type' do
      
      it 'wont accept blank' do
        proxy.type = ''
        proxy.wont_be :valid?
      end
      
      it 'wont accept invalid format' do
        proxy.type = (0...8).map{65.+(rand(25)).chr}.join.gsub('/', '')
      end

    end
    
    describe 'size' do
        
      it 'wont accept blank' do
        proxy.size = ''
        proxy.wont_be :valid?
      end
      
      it 'wont accept 0' do
        proxy.size = 0
        proxy.wont_be :valid?
      end
      
      it 'wont accept < 0' do
        proxy.size = -1
        proxy.wont_be :valid?
      end
      
    end
    
  end
  
  describe 'associations' do
    
    it 'wont accept blank asset id' do
      proxy.asset_id = ''
      proxy.wont_be :valid?
    end
    
  end

end

