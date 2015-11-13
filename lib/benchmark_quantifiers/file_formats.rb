require 'csv'

class FileFormats

  def initialize(filename)
    @filename = filename
  end

  attr_accessor :filename

  def read_file()
    raise "Not defined yet!"
  end

  def template(mode="default")
    raise "Not defined yet!"
  end

end