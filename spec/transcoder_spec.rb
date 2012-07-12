require_relative 'spec_helper'

describe Transcoder do

  let :container do
    MiniTest::Mock.new
  end
  
  let :transcoder do
    Transcoder
  end
  
  it 'sets and gets formats' do
    transcoder.formats = {}
    transcoder.formats.must_equal({})
  end
  
  it 'wraps input in movie container' do
    container.expect :new, true, ['input']
    transcoder.new 'input', container
    container.verify
  end
  
  describe 'transcode' do
    
    before do
      transcoder.format :mp4, {}
    end
    
    it 'calls movie container with options' do
      container.expect :new, container, ['input']
      container.expect :transcode, container, [String, Hash, Hash]
      transcoder.new('input', container).transcode :mp4
      container.verify
    end
    
  end
  
  describe 'screenshot' do
    
    it 'calls movie container with options' do
      container.expect :new, container, ['input']
      container.expect :screenshot, container, [String, Hash, Hash]
      transcoder.new('input', container).screenshot
      container.verify
    end
    
  end
  
end

