class TestHarness

  def initialize(test_names)
    @test_names = test_names
  end

  def run
    tests.each do |test|
      printf "Running #{test.path}...\t"
      puts test.passed? ? "passed [#{test.score} bytes]" : "failed! :("
    end
    render_result
  end

  def passed?
    tests.all?(&:passed?)
  end

  private

  def tests
    @test_names.map { |name| TestFile.new name }
  end

  def render_result
    if passed?
      puts "----"
      puts "Your score: #{total}"
    else
      puts "DISQUALIFIED"
      tests.each { |t| render_diff t unless t.passed? } 
    end
  end

  def total
    tests.map(&:score).inject(0, :+)
  end

  def render_diff(t)
    puts
    puts "#{t.name} diff:"
    puts t.diff
  end

  class TestFile
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def score
      @score ||= File.read(path).size
    end

    def filename
      @filename ||= "#{name}.rb"
    end

    def path
      @path ||= File.join 'src', filename
    end

    def passed?
      @passed ||= diff.empty?
    end

    def diff
      @diff ||= %x[
        bash -c "diff test/data/#{name}.txt <(ruby #{path})"
      ]
    end
  end

end