require "test_helper"

class CategoriesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @family = create(:family)
    @category = create(:category, family: @family)

    @account = create(:account, family: @family)
    sign_in(@account)
  end

  test "/category" do
    get "/category"
    assert_response(:success)
    assert_match("<a href=\"#{category_path(@category)}\">#{@category.name}</a>", @response.body)
  end

  test "/category/:id" do
    get category_path(@category)
    assert_response(:success)
    assert_match(@category.name, @response.body)
  end
end