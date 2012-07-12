require_relative '../spec_helper'

describe Store::Item do

  before do
    FakeFS.activate!
  end
  
  after do
    FakeFS.deactivate!
  end
  
  def filename
    'example.txt'
  end
  
  def file_path
    "/path/to/#{filename}"
  end
  
  def file_contents
    'hello, world'
  end
  
  def bin_id
    '123'
  end
  
  let :base do
    Store::Base.new '/path/to/base'
  end
  
  let :bin do
    Store::Bin.new base, bin_id
  end
  
  def item_path
    File.join bin.path, filename
  end
  
  before do
    FileUtils.mkdir_p '/path/to'
  end
  
  describe 'class methods' do
    
    describe 'create' do
      
      before do
        FileUtils.touch file_path
      end
      
      it 'creates a new item with a given file' do
        Store::Item.create bin, file_path
        File.file?(item_path).must_equal true
      end
      
    end
    
  end
  
  describe 'instance methods' do
    
    let :item do
      Store::Item.create bin, file_path
    end
    
    describe '<<' do
      
      it 'appends data to a given item' do
        item << file_contents
        File.open(item.path) {|f| f.read.must_equal file_contents }
      end
      
    end
    
    describe 'read' do
      
      it 'returns the contents of a given item' do
        item << file_contents
        item.read.must_equal file_contents
      end
      
    end
    
    describe 'destroy' do
      
      before do
        item
        File.file?(item_path).must_equal true
      end
      
      it 'removes item' do
        item.destroy
        File.file?(item_path).wont_equal true
      end
      
    end
    
  end
  
end
