class DynamicTestCase
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def score
    @score ||= File.size path
  end

  def passed?
    @passed ||= diff.empty?
  end

  def name
    @name ||= File.basename path, '.rb'
  end

  def diff
    
  end
  
end
