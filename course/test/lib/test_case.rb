class TestCase
  attr_reader :path, :errors

  def initialize(path)
    @path = path
    @errors = []
  end

  def hole
    name.split('_').first.to_i
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

  def test_dir
    @test_dir ||= name.split('_')[1..-1].join('_')
  end

  def reference_input
    @reference_input ||= File.join 'test', 'cases', test_dir, 'in.txt'
  end

  def reference_output
    @reference_output ||= File.join 'test', 'cases', test_dir, 'out.txt'
  end

  def reference_input_lines
    @reference_input_lines ||= File.readlines reference_input
  end

  def reference_output_lines
    @reference_output_lines ||= File.readlines reference_output
  end

  def diff
    @diff ||= reference_output_lines.each_with_index.select { |l,i| l != output_lines[i] }.map do |l,i| 
      "Line #{i+1}: expected #{l.inspect} got #{output_lines[i].inspect}"
    end
  end

  def output_lines
    @output_lines ||= IO.popen("ruby #{path}", 'r+') do |io|
      io.puts reference_input_lines
      io.close_write
      io.readlines
    end
  end
end
