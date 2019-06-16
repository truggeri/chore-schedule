require "test_helper"

class StaticPagesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @family   = create(:family)
    @account  = create(:account, family: @family)
    sign_in(@account)
  end

  test "/dashboard" do
    get "/dashboard"
    assert_response(:success)
  end

  test "/index" do
    get "/"
    assert_response(:success)
  end
end