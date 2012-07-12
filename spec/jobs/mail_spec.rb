require_relative '../spec_helper'

describe Job::Mail do

  describe 'perform' do
      
    let :mailer do
      MiniTest::Mock.new
    end
    
    let :job do
      Job::Mail
    end
    
    describe 'perform' do
      
      it 'calls mailer with options' do
        mailer.expect :mail, true, [{to: 'to', from: 'from', subject: 'subject', body: 'body'}]
        job.new(mailer, 
          'to' => 'to', 'from' => 'from', 'subject' => 'subject', 'body' => 'body').perform
        mailer.verify
      end
      
    end
  end
end