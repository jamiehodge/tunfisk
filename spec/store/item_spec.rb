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
  
  def item_path
    '/path/to/item'
  end
  
  describe 'class methods' do
    
    before do
      FileUtils.mkdir_p '/path/to'
    end
    
    describe 'create' do
      
      before do
        FileUtils.touch file_path
      end
      
      it 'creates a new item with a given file' do
        Store::Item.create file_path, item_path
        File.file?(item_path).must_equal true
      end
      
    end
    
  end
  
  describe 'instance methods' do
    
    let :item do
      Store::Item.create file_path, item_path
    end
    
    describe '<<' do
      
      it 'appends data to a given item' do
        item << file_contents
        File.open("#{item_path}/#{filename}") {|f| f.read.must_equal file_contents }
      end
      
    end
    
    describe 'read' do
      
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
