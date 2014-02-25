class StaticTestCase
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

  def reference_input
    @reference_input ||= File.join 'test', 'cases', name, 'in.txt'
  end

  def reference_output
    @reference_output ||= File.join 'test', 'cases', name, 'out.txt'
  end

  def diff
    @diff ||= %x[
      bash -c "diff <(cat #{reference_input} | ruby #{path}) #{reference_output}"
    ]
  end
end
