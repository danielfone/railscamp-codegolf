namespace :team do
  task :create => :environment do
    Team.create! name: ENV.fetch('name')
  end

  task :score => :environment do
    name = ENV.fetch('name')
    path = ENV.fetch('path')

    Dir.chdir File.join(Rails.root,'..','course')

    require './test/lib/test_harness'
    require './test/lib/test_case'

    STDOUT.sync = true

    holes = Dir[File.join path, "holes/*.rb"]

    tests = holes.map { |h| TestCase.new h }

    harness = TestHarness.new tests
    harness.run
    
    team = Team.find_by! name: name
    tests.each { |t| team.scores[t.hole-1] = t.score }
    team.save!

  end
end
