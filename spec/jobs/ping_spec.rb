require_relative '../spec_helper'

describe Job::Ping do

  describe 'perform' do
      
    let :client do
      MiniTest::Mock.new
    end
    
    let :job do
      Job::Ping
    end
    
    describe 'perform' do
      
      it 'calls client with options' do
        client.expect :get_response, true, ["#{job::URL}?feedURL=url"]
        job.new(client, {'url' => 'url'}).perform
        client.verify
      end
      
    end
  end
end
