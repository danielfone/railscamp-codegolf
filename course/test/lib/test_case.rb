class TestCase
  attr_reader :path, :errors

  def initialize(path)
    @path = path
    @errors = []
  end

  def score
    @score ||= File.size path
  end

  def passed?
    @passed ||= valid? && diff.empty?
  end

  def valid?
    @errors.clear
    @errors.push "#{reference_input} not found" unless File.exists?(reference_input)
    @errors.push "#{reference_output} not found" unless File.exists?(reference_output)
    @errors.push "#{path} not found" unless File.exists?(path)
    @errors.empty?
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
