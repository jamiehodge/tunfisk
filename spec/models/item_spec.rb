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
    
    describe 'blank' do
      
      it 'must return all records' do
        Item.text_search('').count.must_equal 1
      end
      
    end
    
    describe 'single word' do
      
      it 'must return matching record' do
        Item.text_search('exa').count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Item.text_search('fr').count.must_equal 0
      end
      
    end
    
    describe 'multiple words' do
      
      it 'must return matching record' do
        Item.text_search('int tes').count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Item.text_search('fl fr').count.must_equal 0
      end
    
    end
    
  end
  
end
