require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @family   = create(:family)
    @account  = create(:account, family: @family)
    @user     = create(:user,    family: @family, account: @account)
    sign_in(@account)
  end

  test "/users" do
    get "/users"
    assert_response(:success)
    assert_match("<a href=\"#{user_path(@user)}\">#{@user.name}</a>", @response.body)
  end

  test "/user/:id" do
    get user_path(@user)
    assert_response(:success)
    assert_match(@user.name, @response.body)
  end
end
