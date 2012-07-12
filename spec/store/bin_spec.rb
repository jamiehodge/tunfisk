require_relative '../spec_helper'

describe Store::Bin do
  
  before do
    FakeFS.activate!
  end
  
  after do
    FakeFS.deactivate!
  end
  
  let :base do
    Store::Base.new '/path/to/base'
  end
  
  def bin_id
    '123'
  end
  
  def bin_path
    File.join base.path, bin_id
  end
  
  def filename
    'example.txt'
  end
  
  def file_path
    "/path/to/#{filename}"
  end
  
  def item_path
    File.join bin_path, filename
  end
  
  describe 'class methods' do
    
    describe 'create' do
      
      it 'creates a new base path' do
        Store::Bin.create base, bin_id
        File.directory?(bin_path).must_equal true
      end
      
    end
    
  end
  
  describe 'instance methods' do
    
    let :bin do
      Store::Bin.create base, bin_id
    end
    
    describe '<<' do
      
      before do
        FileUtils.touch file_path
      end
      
      it 'creates a given item path' do
        bin << file_path
        File.file?(item_path).must_equal true
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
        bin.each.count.must_equal 1
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
