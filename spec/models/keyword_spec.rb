require_relative '../spec_helper'

describe Keyword do
  
  let :keyword do
    Fabricate.build :keyword
  end
  
  describe 'validation' do
    
    it 'wont validate blank names' do
      keyword.name = ''
      keyword.wont_be :valid?
    end
    
    it 'must validate valid names' do
      keyword.must_be :valid?
    end
    
    it 'wont validate overly long names' do
      keyword.name = '*'*256
      keyword.wont_be :valid?
    end
    
  end
  
  describe 'full_text_search' do
    
    before do
      keyword.save
    end
    
    describe 'blank' do
      
      it 'must return all records' do
        Keyword.text_search('').count.must_equal 1
      end
      
    end
    
    describe 'single word' do
      
      it 'must return matching record' do
        Keyword.text_search('fo').count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Keyword.text_search('fr').count.must_equal 0
      end
      
    end
    
    describe 'multiple words' do
      
      it 'must return matching record' do
        Keyword.text_search('f fo').count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Keyword.text_search('fl fr').count.must_equal 0
      end
    
    end
    
  end
  
end

