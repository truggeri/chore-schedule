class AddAccountIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column(:users, :account_id, :bigint, nil: false)
  end
end
