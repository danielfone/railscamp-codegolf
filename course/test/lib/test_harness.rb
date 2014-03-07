class TestHarness

  def initialize(tests)
    @tests = tests
  end

  def run
    @tests.each do |test|
      printf "Running %-22s" % test.name
      if test.valid?
        puts test.passed? ? "passed [#{test.score} bytes]" : "failed! :("
      else
        puts "skipping"
      end
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
      puts
      puts "Errors"
      @tests.each do |test|
        if test.errors.any?
          puts test.errors.map { |e| "\t#{e}" }
        elsif not test.passed?
          render_diff test
        end
      end
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
