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

  test "POST /chores" do
    chore_count = Chore.count

    post chores_path, params: { chore: { description: "Foo that bar", frequency: 3, frequency_type: :days } }
    assert_response(:redirect)
    assert_equal(chore_count + 1, Chore.count)
  end

  test "POST /chores failure" do
    chore_count = Chore.count

    post chores_path, params: { chore: { description: "Foo that bar" } }
    assert_response(:success)
    assert_equal(chore_count, Chore.count)
  end

  test "PUT /chore/:id" do
    put chore_path(@chore), params: { chore: { description: "Flavor Town" } }
    assert_response(:redirect)
    @chore.reload
    assert_equal("Flavor Town", @chore.description)
  end

  test "DELETE /chore/:id" do
    delete chore_path(@chore)
    assert_response(:redirect)
    assert_equal(0, Chore.where(id: @chore.id).count)
  end

  test "/chore/:id/perform_now" do
    cpl_count = ChorePerformanceLog.where(chore: @chore, user: @account.user).count

    get perform_now_chore_path(@chore), xhr: true
    assert_response(:redirect)
    @chore.reload
    assert((Time.now.utc - @chore.last_performed).abs < 15.minutes)
    assert(cpl_count + 1, ChorePerformanceLog.where(chore: @chore, user: @account.user).count)
  end
end