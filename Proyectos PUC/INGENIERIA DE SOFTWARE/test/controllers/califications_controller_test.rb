require 'test_helper'

class CalificationsControllerTest < ActionDispatch::IntegrationTest
    fixtures :usuarios, :products
    setup do
        @usuario_one = usuarios(:usuario_one)
      @usuario_two = usuarios(:usuario_two)
      @product = products(:product_one)

      sign_in @usuario_one
    end

    test "should get new" do
        get new_calification_url,
            params: { usuario_calificado_id: @usuario_two.id, usuario_calificador_id: @usuario_one.id,
producto_id: @product.id }
      assert_response :success
    end

    test "should create calification" do
        assert_difference('Calification.count') do
            post califications_url, params: { calification: { usuario_calificador_id: @usuario_one.id,
              usuario_calificado_id: @usuario_two.id, puntuacion: 5, mensaje: 'Salio bien', product_id: @product.id } }
        end
      assert_redirected_to root_path
    end

    teardown do
        Rails.cache.clear
    end
end


