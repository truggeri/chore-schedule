class AddFamilyToEverything < ActiveRecord::Migration[5.2]
  def up
    puts "Finding family..."
    fam = Family.last
    [Account, User, Chore, Category, ChorePerformanceLog].each { |k| update_class(k, fam) } if fam.present?
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

  private

  def update_class(klass, family)
    puts "Updating #{klass}..."
    count = 0
    items = klass.where(family: nil)
    items.each do |i|
      i.family = family
      count += 1 if i.save
    end
    puts "... updated #{count} records"
  end
end
