class CreateChorePerformanceLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :chore_performance_logs do |t|
      t.bigint      :chore_id,      null: false
      t.text        :notes
      t.timestamp   :performed_at,  null: false
      t.bigint      :user_id
      t.timestamps
    end
  end
end
