require_relative '../spec_helper'

describe Asset do
  
  let :asset do
    Fabricate :asset
  end
  
  describe 'validation' do
      
    it 'must accept valid' do
      asset.must_be :valid?
    end
    
    describe 'name' do
      
      it 'wont accept blank' do
        asset.name = ''
        asset.wont_be :valid?
      end
      
      it 'wont accept too long' do
        asset.name = '*'*256
        asset.wont_be :valid?
      end
      
    end
   
    describe 'type' do
      
      it 'wont accept blank' do
        asset.type = ''
        asset.wont_be :valid?
      end
      
      it 'wont accept invalid format' do
        asset.type = (0...8).map{65.+(rand(25)).chr}.join.gsub('/', '')
      end

    end
    
    describe 'size' do
        
      it 'wont accept blank' do
        asset.size = ''
        asset.wont_be :valid?
      end
      
      it 'wont accept 0' do
        asset.size = 0
        asset.wont_be :valid?
      end
      
      it 'wont accept < 0' do
        asset.size = -1
        asset.wont_be :valid?
      end
      
    end
    
  end
  
  describe 'associations' do
    
    it 'wont accept blank item id' do
      asset.item_id = ''
      asset.wont_be :valid?
    end
  end
  
  describe 'full_text_search' do
    
    before do
      asset
    end
    
    def text
      asset.name.split.sample
    end
    
    describe 'blank' do
      
      it 'must return all records' do
        Asset.text_search('').count.must_equal 1
      end
      
    end
    
    describe 'single word' do
      
      it 'must return matching record' do
        Asset.text_search(text).count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Item.text_search('xyzzy').count.must_equal 0
      end
      
    end
    
    describe 'multiple words' do
      
      it 'must return matching record' do
        Asset.text_search([text, text].join(' ')).count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Asset.text_search('xy zz y').count.must_equal 0
      end
    
    end
  
  end

end

