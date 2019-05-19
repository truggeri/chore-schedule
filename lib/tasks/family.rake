namespace :family do
  desc "List all families"
  task :list => :environment do
    fams = Family.all.pluck(:id, :name)
    fams.each { |f| puts "#{f[0]}: '#{f[1]}'" }
  end

  desc "Create a family"
  task :create, [:name] => :environment do |_task, args|
    fam = Family.create(name: args[:name])
    puts "# Family created successfully with id #{fam.id}" if fam&.persisted?
  end

  desc "Remove a family"
  task :remove, [:id] => :environment do |_task, args|
    fam = Family.find_by(id: args[:id].to_i)
    fam = Family.find_by(name: args[:id]) unless fam.present?
    fam.delete if fam.present?
  end
end
