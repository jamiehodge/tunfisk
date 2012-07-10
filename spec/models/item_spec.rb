require_relative '../spec_helper'

describe Item do

  let :item do
    Fabricate :item
  end
  
  describe 'validation' do
      
    it 'must accept valid' do
      item.must_be :valid?
    end
    
    describe 'title' do
      
      it 'wont accept too long' do
        item.title = '*'*256
        item.wont_be :valid?
      end
      
    end
   
    describe 'description' do
      
      it 'wont accept blank' do
        item.description = ''
        item.wont_be :valid?
      end

    end
    
    describe 'explicit' do
        
      it 'wont accept blank' do
        item.explicit = ''
        item.wont_be :valid?
      end
      
    end
    
    describe 'associations' do
      
      it 'wont accept blank collection id' do
        item.collection_id = ''
        item.wont_be :valid?
      end
      
      it 'wont accept blank category id' do
        item.category_id = ''
        item.wont_be :valid?
      end
      
      it 'wont accept blank subcategory id' do
        item.subcategory_id = ''
        item.wont_be :valid?
      end
      
    end

  end
  
  describe 'full_text_search' do
    
    before do
      item
    end
    
    def text
      [item.title, item.description].collect(&:split).flatten.sample
    end
    
    describe 'blank' do
      
      it 'must return all records' do
        Item.text_search('').count.must_equal 1
      end
      
    end
    
    describe 'single word' do
      
      it 'must return matching record' do
        Item.text_search(text).count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Item.text_search('xyzzy').count.must_equal 0
      end
      
    end
    
    describe 'multiple words' do
      
      it 'must return matching record' do
        Item.text_search([text, text].join(' ')).count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Item.text_search('xy zz y').count.must_equal 0
      end
    
    end
    
  end
  
end
