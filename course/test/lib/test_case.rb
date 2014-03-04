class TestCase
  attr_reader :path, :errors

  def initialize(path)
    @path = path
    @errors = []
  end

  def score
    @score ||= File.size(path) if valid? and passed?
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

  def reference_input_lines
    @reference_input_lines ||= File.readlines reference_input
  end

  def reference_output_lines
    @reference_output_lines ||= File.readlines reference_output
  end

  def diff
    @diff ||= output_lines.each_with_index.select { |l,i| l != reference_output_lines[i] }.map do |l,i| 
      "Line #{i+1}: expected #{l.inspect} got #{reference_output_lines[i].inspect}"
    end
  end

  def output_lines
    IO.popen("ruby #{path}", 'r+') do |io|
      io.puts reference_output_lines
      return io.readlines
    end
  end
end
