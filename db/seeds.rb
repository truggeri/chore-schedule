# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

fam = Family.create(name: FFaker::Name.last_name)

acc = Account.create(email: "test@dev.com", name: "Test Account",
               password: ENV['SEED_PASSWORD'] || "password1234",
               password_confirmation: ENV['SEED_PASSWORD'] || "password1234", family: fam)

%w[Thomas Claire Benny Lilah].each do |name|
  User.create!(name: name, account: acc, family: fam)
end

cats = {}
cats[:bathroom] = Category.create!(name: "Bathroom", color: nil, family: fam)
cats[:bedroom]  = Category.create!(name: "Bedroom", color: nil, family: fam)
cats[:kitchen]  = Category.create!(name: "Kitchen", color: nil, family: fam)
cats[:living]   = Category.create!(name: "Living Room", color: nil, family: fam)
cats[:yard]     = Category.create!(name: "Yard", color: nil, family: fam)
cats[:garage]   = Category.create!(name: "Garage", color: nil, family: fam)

Chore.create!(description: "Clean shower", frequency: 1, frequency_type: :weeks, category_id: cats[:bathroom].id, family: fam)
Chore.create!(description: "Clean toilet", frequency: 2, frequency_type: :weeks, category_id: cats[:bathroom].id, family: fam)
Chore.create!(description: "Clean mirror", frequency: 3, frequency_type: :days, category_id: cats[:bathroom].id, family: fam)

Chore.create!(description: "Vacuum bedroom", frequency: 1, frequency_type: :weeks, category_id: cats[:bedroom].id, family: fam)
Chore.create!(description: "Wash sheets", frequency: 2, frequency_type: :weeks, category_id: cats[:bedroom].id, family: fam)

Chore.create!(description: "Wash dishes", frequency: 1, frequency_type: :days, category_id: cats[:kitchen].id, family: fam)
Chore.create!(description: "Clean countertops", frequency: 1, frequency_type: :weeks, category_id: cats[:kitchen].id, family: fam)
Chore.create!(description: "Vacuum kitchen", frequency: 2, frequency_type: :weeks, category_id: cats[:kitchen].id, family: fam)

Chore.create!(description: "Vacuum living room", frequency: 2, frequency_type: :weeks, category_id: cats[:living].id, family: fam)

Chore.create!(description: "Mow lawn", frequency: 7, frequency_type: :days, category_id: cats[:yard].id, family: fam)
Chore.create!(description: "Water plans", frequency: 2, frequency_type: :days, category_id: cats[:yard].id, family: fam)

Chore.create!(description: "Pay water bill", frequency: 1, frequency_type: :months, category_id: nil, family: fam)
Chore.create!(description: "Change motor oil", frequency: 4, frequency_type: :months, category_id: nil, family: fam)

user_ids = User.all.pluck(:id)
chore_ids = Chore.all.pluck(:id)
chore_ids.each do |chore_id|
  performed = Random.rand(0..4)
  (0..performed).each do |_i|
    log = ChorePerformanceLog.create(chore_id: chore_id, user_id: user_ids.sample, family: fam)
    log.performed_at = Random.rand(1..50).days.ago
    log.save
  end
  performed_at = ChorePerformanceLog.where(chore_id: chore_id)
                                    .order(performed_at: :desc).limit(1).pluck(:performed_at)
  chore = Chore.find_by(id: chore_id)
  chore.last_performed = performed_at[0]
  chore.perform_next = performed_at[0] + chore.frequency_to_time
  chore.save

  random_user_id = user_ids.sample
  times_done = ChorePerformanceLog.where(chore: chore, user_id: random_user_id).count
  Assignment.create(chore: chore, user_id: random_user_id, times_performed: times_done) if Random.rand(0..2).zero?
end