require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
    fixtures :admins

    test "deberia redireccionar a root" do
        get admin_root_url
      assert_redirected_to root_url
    end

    test "deberia entrar al panel de admin" do
        sign_in admins(:admin_one)
      get admin_root_url
      assert_response :success
    end

end
