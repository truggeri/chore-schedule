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
    assert_match("Create Chore", @response.body)
  end

  test "POST /category" do
    cat_count = Category.count
    post "/category", params: { category: { name: "Foo that bar" } }
    assert_response(:redirect)
    assert_equal(cat_count + 1, Category.count)
  end

  test "POST /category failure" do
    cat_count = Category.count
    post "/category", params: { category: { name: "" } }
    assert_response(:redirect)
    assert_equal(cat_count, Category.count)
  end

  test "DELETE /category/:id" do
    delete category_path(@category)
    assert_response(:redirect)
    assert_equal(0, Category.where(id: @category.id).count)
  end
end