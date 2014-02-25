class TestHarness

  def initialize(tests)
    @tests = tests
  end

  def run
    @tests.each do |test|
      printf "Running #{test.path}...\t"
      puts test.passed? ? "passed [#{test.score} bytes]" : "failed! :("
    end
    render_result
  end

  def passed?
    @tests.all?(&:passed?)
  end

private

  def render_result
    if passed?
      puts "----"
      puts "Your score: #{total}"
    else
      puts "DISQUALIFIED"
      @tests.each { |t| render_diff t unless t.passed? } 
    end
  end

  def total
    @tests.map(&:score).inject(0, :+)
  end

  def render_diff(t)
    puts
    puts "#{t.name} diff:"
    puts t.diff
  end

end
