require 'minitest_helper'

class TestJob < Minitest::Test
  def setup
    jobnumber = 123
    cmd = "echo hallo"
    status = "RUN"
    working_dir = "/home/hayer"
    @job = Job.new(jobnumber, cmd, status, working_dir)
  end

  def test_read_file
    s = @job.to_s
    assert_equal("Jobnumber 123; Cmd: echo hallo; Status: RUN; WD: /home/hayer", s)
  end
end
