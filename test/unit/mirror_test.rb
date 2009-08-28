require 'test/test_helper'

class MirrorTest < ActiveSupport::TestCase

  test "enable and disable" do
    Mirror.create!(:domain => 'rubyforge.vm.bytemark.co.uk', :serves_gems => true, :url => 'http://gems.rubyforge.vm.bytemark.co.uk')
    assert_difference 'Mirror.enabled.size', -1 do
      Mirror.first.disable!
    end
  end

end
