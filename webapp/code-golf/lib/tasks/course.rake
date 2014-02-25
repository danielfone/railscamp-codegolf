COURSE_PATH = File.join Rails.root, 'greenkeeper'

namespace :course do

  task :generate_test_cases do
    
  end

  task :check do
    require_relative "#{COURSE_PATH}/test/lib/test_harness"
    STDOUT.sync = true

    holes = Dir["#{COURSE_PATH}/{holes,best,pars}/*"]

    harness = TestHarness.new holes
    harness.run
    exit harness.passed? ? 0 : -1    
  end

  task :load => :environment do
    puts "Clearing course..."
    Hole.destroy_all
    puts "Loading holes in #{COURSE_PATH}..."
    Dir["#{COURSE_PATH}/holes/*"].each do |hole_path|
      filename = File.basename hole_path

      best_path = "#{COURSE_PATH}/best/#{filename}"
      par_path  = "#{COURSE_PATH}/pars/#{filename}"

      puts "\t"+filename
      match, number, hole_name = filename.match(/(\d+)_(\w+).rb/).to_a

      length = File.size? hole_path
      best   = File.size? best_path
      par    = File.size? par_path

      Hole.create! id: number, name: hole_name, length: length, best: best, par: par
    end
    puts "Done"
  end

end
#rm -fr master_repo/
#cp -r code/ master_repo/
#cd master_repo
#git init
#git add -A
#git commit -m "chch-ruby code golf"
