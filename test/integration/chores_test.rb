require "test_helper"

class ChoresTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @family = create(:family)
    @chore = create(:chore, family: @family)

    @account = create(:account, family: @family)
    sign_in(@account)
  end

  test "/chores" do
    get chores_path
    assert_response(:success)
    assert_match("<a href=\"#{chore_path(@chore)}\">#{@chore.description}</a>", @response.body)
  end

  test "/chore/:id" do
    get chore_path(@chore)
    assert_response(:success)
    assert_match(@chore.description, @response.body)
  end
end