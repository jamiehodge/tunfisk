require_relative '../spec_helper'

describe Keyword do
  
  let :keyword do
    Fabricate :keyword
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
      keyword
    end
    
    def text
      keyword.name.split.sample
    end
    
    describe 'blank' do
      
      it 'must return all records' do
        Keyword.text_search('').count.must_equal 1
      end
      
    end
    
    describe 'single word' do
      
      it 'must return matching record' do
        Keyword.text_search(text).count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Keyword.text_search('xyzzy').count.must_equal 0
      end
      
    end
    
    describe 'multiple words' do
      
      it 'must return matching record' do
        Keyword.text_search([text, text].join(' ')).count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Keyword.text_search('xy zz y').count.must_equal 0
      end
    
    end
    
  end
  
end

