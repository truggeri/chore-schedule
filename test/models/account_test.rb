# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  family_id              :bigint(8)
#
# Indexes
#
#  index_accounts_on_email                 (email) UNIQUE
#  index_accounts_on_family_id             (family_id)
#  index_accounts_on_reset_password_token  (reset_password_token) UNIQUE
#

require "test_helper"

class AccountTest < ActiveSupport::TestCase
  def setup
    @account = create(:account)
  end

  test "has family" do
    @account.family = nil
    assert(!@account.valid?)
  end
end
