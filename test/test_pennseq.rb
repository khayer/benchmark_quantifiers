require 'minitest_helper'

class TestPennseq < Minitest::Test
  def setup
    @pennseq = Pennseq.new("files/pennseq_out")
  end

  def test_read_file
    @pennseq.read_file()
    assert_equal(2.11973206612107e-49, @pennseq.fpkm["ENSMUST00000155286"])
  end
end
