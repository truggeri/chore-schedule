require "test_helper"

class CategoriesTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @family   = create(:family)
    @category = create(:category, family: @family)
    @account  = create(:account, family: @family)
    sign_in(@account)
  end

  test "/category" do
    (0..Random.rand(0..2)).each { |_i| create(:category, family: @family) }

    get "/category"
    assert_response(:success)
    assert_match("<a href=\"#{category_path(@category)}\">#{@category.name}</a>", @response.body)
    assert_equal(Category.family(@family).count, @response.body.scan(/<a href=.{1,2}\/category\/\d+/).size)
  end

  test "/category/:id" do
    get category_path(@category)
    assert_response(:success)
    assert_match(@category.name, @response.body)
  end
end