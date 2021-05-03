class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.integer     :chore_count, null: false, default: 0
      t.string      :color,       null: true,  limit: 6
      t.string      :name,        null: false

      t.timestamps
    end

    add_index :categories, :name
  end
end
