class Job
  def initialize(jobnumber, cmd, status, working_dir)
    @jobnumber = jobnumber
    @cmd = cmd
    @status = status
    @working_dir = working_dir
  end

  attr_accessor :jobnumber, :cmd, :status

  def to_s
    "Jobnumber #{@jobnumber}; Cmd: #{@cmd}; Status: #{@status}; WD: #{@working_dir}"
  end

  def update_status
    begin
      l = `bjobs -l #{@jobnumber}`
    rescue Exception => e
      $logger.error(e)
      $logger.error("bjobs not found!\n#{self}")
      @status = "EXIT"
      return
    end
    # if @status == "EXIT"
    l.chomp!
    if l == ""
      $logger.error("Jobnumber #{@jobnumber} not found! #{self}")
      @status = "EXIT"
    else
      l = l.delete(" \n")
      @status = l.split("Status")[1].split(",")[0].gsub(/\W/,"")
    end
  end

end
