class AddAccountIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column(:users, :account_id, :bigint, nil: false)
  end
end
