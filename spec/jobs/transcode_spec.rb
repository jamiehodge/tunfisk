require_relative '../spec_helper'

describe Job::Transcode do
  
  describe 'perform' do
      
    let :transcoder do
      MiniTest::Mock.new
    end
    
    let :job do
      Job::Transcode
    end
    
    let :asset do
      Fabricate :asset
    end
    
    describe 'perform' do
      
      before do
        Fabricate :asset
        FakeFS.activate!
        FileUtils.touch 'input.mov'
      end
      
      after do
        FakeFS.deactivate!
      end
      
      it 'calls transcoder with options' do
        skip 'Needs better mocks'
        transcoder.expect :new, transcoder, [String]
        transcoder.expect :screenshot, transcoder
        transcoder.expect :transcode, [Symbol]
        transcoder.expect :path, 'input.mov'
        job.new(transcoder, {'asset_id' => asset.id, 'input' => 'input.mov'}).perform
        transcoder.verify
      end
      
    end
    
  end
  
end

