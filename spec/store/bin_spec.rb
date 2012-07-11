require_relative '../spec_helper'

describe Store::Bin do
  
  before do
    FakeFS.activate!
  end
  
  after do
    FakeFS.deactivate!
  end
  
  def bin_path
    '/path/to/bin'
  end
  
  def filename
    'example.txt'
  end
  
  def file_path
    "/path/to/#{filename}"
  end
  
  describe 'class methods' do
    
    describe 'create' do
      
      it 'creates a new base path' do
        Store::Bin.create bin_path
        File.directory?(bin_path).must_equal true
      end
      
    end
    
  end
  
  describe 'instance methods' do
    
    let :bin do
      Store::Bin.create bin_path
    end
    
    describe '<<' do
      
      before do
        FileUtils.touch file_path
      end
      
      it 'creates a given item path' do
        bin << file_path
        File.file?("#{bin_path}/#{filename}").must_equal true
      end
      
      it 'returns the created bin' do
        bin.<<(file_path).must_be_kind_of Store::Item
      end
      
    end
    
    describe '[]' do
      
      it 'returns a given item' do
        bin[filename].must_be_kind_of Store::Item
      end
      
    end
    
    describe 'each' do
      
      before do
        bin << file_path
      end
      
      it 'returns an enumerator of items' do
        bin.each.must_be_kind_of Enumerator
        bin.each {|item| item.must_be_kind_of Store::Item }
        bin.each.count.must_equal 1
      end
      
    end
    
    describe 'destroy' do
      
      before do
        bin
        File.directory?(bin_path).must_equal true
      end
      
      it 'removes base directory' do
        bin.destroy
        File.directory?(bin_path).wont_equal true
      end
      
    end
    
  end
  
end
