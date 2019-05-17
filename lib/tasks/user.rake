namespace :user do
  desc "List all users"
  task :list => :environment do
    users = User.all.pluck(:id, :name)
    users.each { |u| puts "#{u[0]}: '#{u[1]}'" }
  end

  desc "Create a user"
  task :create, [:name] => :environment do |_task, args|
    user = User.create(name: args[:name])
    puts "# User created successfully with id #{user.id}" if user&.persisted?
  end

  desc "Remove a user"
  task :remove, [:id] => :environment do |_task, args|
    user = User.find_by(id: args[:id].to_i)
    user = User.find_by(name: args[:id]) unless user.present?
    user.delete if user.present?
  end

  desc "Remove all users"
  task :remove_all, [:confirm] => :environment do |_taks, args|
    if args[:confirm] == "yes"
      User.all.each do |user|
        user.delete
      end
    end
  end
end
