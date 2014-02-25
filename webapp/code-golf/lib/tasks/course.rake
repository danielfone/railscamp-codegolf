namespace :course do
  task :check_holes do
    
  end

  task :load_holes => :environment do
    Hole.destroy_all
    Dir["./greenkeeper/holes/*"].each do |hole_path|
      filename = File.basename hole_path

      best_path = "./greenkeeper/best/#{filename}"
      par_path = "./greenkeeper/pars/#{filename}"

      puts filename
      match, number, hole_name = filename.match(/(\d+)_(\w+).rb/).to_a

      length = File.size? hole_path
      best   = File.size? best_path
      par    = File.size? par_path

      Hole.create! id: number, name: hole_name, length: length, best: best, par: par
    end
  end
end
#rm -fr master_repo/
#cp -r code/ master_repo/
#cd master_repo
#git init
#git add -A
#git commit -m "chch-ruby code golf"
