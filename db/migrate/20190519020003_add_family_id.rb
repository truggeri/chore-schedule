class AddFamilyId < ActiveRecord::Migration[6.0]
  def change
    %i[categories chores chore_performance_logs accounts users].each do |table|
      add_column table, :family_id, :bigint
      add_index table, :family_id
    end
  end
end
