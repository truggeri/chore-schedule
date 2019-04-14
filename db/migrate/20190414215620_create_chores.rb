class CreateChores < ActiveRecord::Migration[5.2]
  def change
    create_table :chores do |t|
      t.bigint      :category_id
      t.string      :description,    null: false, unique: true
      t.integer     :frequency,      null: false
      t.integer     :frequency_type, null: false, default: 0
      t.timestamps 
    end

    add_index :chores, :category_id
  end
end
