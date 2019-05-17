namespace :account do
  desc "List all accounts"
  task :list => :environment do
    accounts = Account.all.pluck(:id, :email)
    accounts.each { |a| puts "#{a[0]}: '#{a[1]}'" }
  end

  desc "Create an account"
  task :create, %i[email name password password_confirmation] => :environment do |_task, args|
    account = Account.create(email: args[:email], name: args[:name],
                             password: args[:password], password_confirmation: args[:password_confirmation])
    puts "# Account created successfully with id #{account.id}" if account&.persisted?
  end

  desc "Remove an account"
  task :remove, [:id] => :environment do |_task, args|
    input = args[:id]

    account = Account.find_by(id: input.to_i)
    account = Account.find_by(email: input) unless account.present?

    account.delete if account.present?
  end
end
