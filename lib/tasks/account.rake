namespace :account do
  desc "List all accounts"
  task :list => :environment do
    accounts = Account.all.pluck(:id, :email)
    accounts.each { |a| puts "#{a[0]}: '#{a[1]}'" }
  end

  desc "Create an account"
  task :create => :environment do
    input = {}
    %i[email name password password_confirmation].each do |field|
      puts "#{field.to_s.humanize}:"
      input[field] = STDIN.gets.chomp
    end

    account = Account.create(email: input[:email], name: input[:name],
                             password: input[:password], password_confirmation: input[:password_confirmation])
    puts "# Account created successfully with id #{account.id}" if account&.persisted?
  end

  desc "Remove an account"
  task :remove => :environment do
    puts "Id or email of account"
    input = STDIN.gets.chomp

    account = Account.find_by(id: input.to_i)
    account = Account.find_by(email: input) unless account.present?

    account.delete
  end
end
