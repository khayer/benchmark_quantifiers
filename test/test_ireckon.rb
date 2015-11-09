require 'minitest_helper'

class TestIReckon < Minitest::Test
  def setup
    @ireckon = IReckon.new("files/ireckon_short.txt")
  end

  def test_read_file
    @ireckon.read_file()
    assert_equal(0.9592210811731112, @ireckon.fpkm["ENSMUST00000127620"])
  end
end
