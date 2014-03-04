COURSE_PATH = File.join Rails.root, '..', 'course'

namespace :course do

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
