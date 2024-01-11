class FileCheck < StoreAccess
  def perform
    raise "File '#{path}' does not exists." unless File.exist?(path)
    raise "File '#{path}' has not the #{required_extension} extension." unless File.extname(path) == required_extension
    raise "File '#{path}' has not the required header." unless header == required_header
  end

  protected

  def required_extension
    '.csv'
  end

  def required_header
    raise "#{self.class} #required_header method is not implemented."
  end

  def path
    raise "#{self.class} #path method is not implemented."
  end

  private

  def header
    File.open(path, &:readline)
  end
end
