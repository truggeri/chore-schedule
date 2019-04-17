class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer     :chores_total,  null: false, default: 0
      t.integer     :chores_week,   null: false, default: 0
      t.string      :name,          null: false, unique: true
      t.timestamps
    end

    add_index :users, :name
  end
end
