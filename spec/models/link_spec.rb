require_relative '../spec_helper'

describe Link do
  
  let :link do
    Fabricate :link
  end
  
  describe 'validation' do
    
    it 'must validate valid' do
      link.must_be :valid?
    end
  
    describe 'name' do
      
      it 'wont validate blank' do
        link.name = ''
        link.wont_be :valid?
      end
    
      it 'wont validate overly long' do
        link.name = '*'*256
        link.wont_be :valid?
      end
      
    end
    
    describe 'url' do
      
      it 'wont validate blank' do
        link.url = ''
        link.wont_be :valid?
      end
    
      it 'wont validate malformed' do
        link.url = 'ssl://invalid'
        link.wont_be :valid?
      end
      
    end

  end
  
  describe 'full_text_search' do
    
    before do
      link
    end
    
    def text
      link.name.split.sample
    end
    
    describe 'blank' do
      
      it 'must return all records' do
        Link.text_search('').count.must_equal 1
      end
      
    end
    
    describe 'single word' do
      
      it 'must return matching record' do
        Link.text_search(text).count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Link.text_search('xyzzy').count.must_equal 0
      end
      
    end
    
    describe 'multiple words' do
      
      it 'must return matching record' do
        Link.text_search([text, text].join(' ')).count.must_equal 1
      end
      
      it 'wont return non-matching record' do
        Link.text_search('xy zz y').count.must_equal 0
      end
    
    end
    
  end
  
end

