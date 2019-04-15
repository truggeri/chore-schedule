class AddLastPerformedToChore < ActiveRecord::Migration[5.2]
  def change
    add_column :chores, :last_performed, :timestamp
    add_column :chores, :perform_next, :timestamp
    add_index :chores, :preform_next
  end
end
