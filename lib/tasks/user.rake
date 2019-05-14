namespace :user do
  desc "List all users"
  task :list => :environment do
    users = User.all.pluck(:id, :name)
    users.each { |u| puts "#{u[0]}: '#{u[1]}'" }
  end

  desc "Create a user"
  task :create => :environment do
    input = {}
    %i[name].each do |field|
      puts "#{field.to_s.humanize}:"
      input[field] = STDIN.gets.chomp
    end

    user = User.create(name: input[:name])
    puts "# User created successfully with id #{user.id}" if user&.persisted?
  end

  desc "Remove a user"
  task :remove => :environment do
    puts "Id or name of user"
    input = STDIN.gets.chomp

    user = User.find_by(id: input.to_i)
    user = User.find_by(name: input) unless user.present?

    user.delete if user.present?
  end

  desc "Remove all users"
  task :remove_all => :environment do
    puts "Type yes to remove all users:"
    input = STDIN.gets.chomp

    if input == "yes"
      User.all.each do |user|
        user.delete
      end
    end
  end
end
