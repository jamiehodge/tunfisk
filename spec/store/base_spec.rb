require_relative '../spec_helper'

describe Store::Base do
  
  before do
    FakeFS.activate!
  end
  
  after do
    FakeFS.deactivate!
  end
  
  def base_path
    '/path/to/base'
  end
  
  describe 'class methods' do
    
    describe 'create' do
      
      it 'creates a new base path' do
        Store::Base.create base_path
        File.directory?(base_path).must_equal true
      end
      
    end
    
  end
  
  describe 'instance methods' do
    
    let :base do
      Store::Base.create base_path
    end
    
    describe '<<' do
      
      it 'creates a given bin path' do
        base << 123
        File.directory?("#{base_path}/123").must_equal true
      end
      
      it 'returns the created bin' do
        base.<<(123).must_be_kind_of Store::Bin
      end
      
    end
    
    describe '[]' do
      
      it 'returns a given bin' do
        base[123].must_be_kind_of Store::Bin
      end
      
    end
    
    describe 'each' do
      
      before do
        base << 123
        base << 456
      end
      
      it 'returns an enumerator of bins' do
        base.each.must_be_kind_of Enumerator
        base.each {|item| item.must_be_kind_of Store::Bin }
        base.each.count.must_equal 2
      end
      
    end
    
    describe 'destroy' do
      
      before do
        base
        File.directory?(base_path).must_equal true
      end
      
      it 'removes base directory' do
        base.destroy
        File.directory?(base_path).wont_equal true
      end
      
    end
    
  end
  
end
