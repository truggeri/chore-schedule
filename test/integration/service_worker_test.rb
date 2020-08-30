require "test_helper"

class ServiceWorkerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup; end

  test "/service-worker.js" do
    get "/service-worker.js"
    assert_response(:success)
  end

  test "/manifest.json" do
    get "/manifest.json"
    assert_response(:success)
  end

  test "/offline.html" do
    get "/offline.html"
    assert_response(:success)
  end
end
