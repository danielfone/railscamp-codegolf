namespace :team do
  task :create => :environment do
    Team.create! name: ENV.fetch('name')
  end
end
