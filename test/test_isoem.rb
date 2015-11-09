require 'minitest_helper'

class TestIsoEM < Minitest::Test
  def setup
    @isoem = IsoEM.new("files/isoem_short.txt")
  end

  def test_read_file
    @isoem.read_file()
    assert_equal(101.11477981724822, @isoem.fpkm["ENSMUST00000022460"])
  end
end
