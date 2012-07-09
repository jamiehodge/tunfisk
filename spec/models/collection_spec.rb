require_relative '../spec_helper'

describe Collection do
  
  let :collection do
    Fabricate.build :collection
  end
  
  describe 'validation' do
    
    it 'must accept valid' do
      collection.must_be :valid?
    end
    
    describe 'title' do
      
      it 'wont accept too long' do
        collection.title = '*'*256
        collection.wont_be :valid?
      end
      
    end
   
    describe 'description' do
      
      it 'wont accept blank' do
        collection.description = ''
        collection.wont_be :valid?
      end

    end
    
    describe 'department' do
        
      it 'wont accept blank' do
        collection.department = ''
        collection.wont_be :valid?
      end
        
      it 'wont accept too long' do
        collection.department = '*'*256
        collection.wont_be :valid?
      end
      
    end
    
    describe 'associations' do
      
      it 'wont accept blank institution id' do
        collection.institution_id = ''
        collection.wont_be :valid?
      end
      
      it 'wont accept blank language id' do
        collection.language_id = ''
        collection.wont_be :valid?
      end
      
      it 'wont accept blank license id' do
        collection.license_id = ''
        collection.wont_be :valid?
      end
      
    end

  end
  
  describe 'full_text_search' do
    
    before do
      collection.save
    end
    
    describe 'blank' do
      
      it 'must return all records' do
        Collection.text_search('').count.must_equal 1
      end
      
    end
    
    describe 'single word' do
      
      it 'must return matching record' do
        Collection.text_search('col').count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Collection.text_search('fr').count.must_equal 0
      end
      
    end
    
    describe 'multiple words' do
      
      it 'must return matching record' do
        Collection.text_search('int tes').count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Collection.text_search('fl fr').count.must_equal 0
      end
    
    end
    
  end
  
end
