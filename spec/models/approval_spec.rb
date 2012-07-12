require_relative '../spec_helper'

describe Approval do
  
  let :approval do
    Fabricate :approval
  end
  
  describe 'validations' do
    
    it 'must accept valid' do
      approval.must_be :valid?
    end
  
    describe 'associations' do
      
      it 'wont accept blank item id' do
        approval.asset_id = ''
        approval.wont_be :valid?
      end
      
      it 'wont accept blank reviewer id' do
        approval.reviewer_id = ''
        approval.wont_be :valid?
      end
      
      it 'wont accept blank status id' do
        approval.status_id = ''
        approval.wont_be :valid?
      end
      
    end
    
  end
  
end
