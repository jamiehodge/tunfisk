ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/pride'

class MiniTest::Spec
  def run *args, &block
    Sequel::Model.db.transaction(rollback: :always) {super}
  end
end

require_relative '../env'
