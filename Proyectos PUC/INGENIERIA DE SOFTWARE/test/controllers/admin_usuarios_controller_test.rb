require 'test_helper'

class Admin::UsuariosControllerTest < ActionDispatch::IntegrationTest
    fixtures :admins, :products, :usuarios, :califications

    setup do
        @admin = admins(:admin_one)
        @usuario = usuarios(:usuario_one)
        @product = products(:product_one)
        @calification = califications(:calification_one)
        sign_in @admin
    end

    test "banear usuario" do
          patch ban_admin_usuario_path(@usuario)
        assert_redirected_to admin_usuarios_path
        @usuario.reload
        assert_not_nil @usuario.locked_at
        assert_equal "El usuario #{@usuario.nombre} ha sido baneado", flash[:notice]
      end

    test "desbanear usuario" do
        patch unban_admin_usuario_path(@usuario)
      assert_redirected_to admin_usuarios_path
      @usuario.reload
      assert_nil @usuario.locked_at
      assert_equal "El usuario #{@usuario.nombre} ha sido desbaneado", flash[:notice]
    end

    test "get usuario products" do
        get admin_usuario_products_url(@usuario)
        assert_response :success
        assert_match @product.nombre, @response.body
    end

    test "get usuario califications" do
        get admin_usuario_califications_url(@usuario)
        assert_response :success
    end

    test "eliminar usuario" do
        assert_difference('Usuario.count', -1) do
            delete destroy_admin_usuario_path(@usuario)
        end
        assert_equal "Se ha eliminado el usuario #{@usuario.nombre}", flash[:notice]
    end


    teardown do
          Rails.cache.clear
      end
end

