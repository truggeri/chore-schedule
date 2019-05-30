class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.bigint  :chore_id, null: false
      t.bigint  :user_id,  null: false
      t.integer :times_performed, null: false, default: 0
      t.timestamps
    end

    add_index(:assignments, :chore_id)
    add_index(:assignments, :user_id)
  end
end
