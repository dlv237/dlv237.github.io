require "test_helper"

class SolicitudControllerTest < ActionDispatch::IntegrationTest

    fixtures :usuarios, :products

    setup do
        @usuario = usuarios(:usuario_one)
        @product_one = products(:product_one)
        @product_two = products(:product_two)
        sign_in @usuario
    end

    test "should get new" do
        get new_solicitud_url(@product_one)
        assert_response :success
    end

    test "should get index" do
        get solicitudes_url
      assert_response :success
    end

    test "create solicitud" do
        assert_difference('Solicitud.count') do
            post create_solicitud_url,
                 params: { solicitud: { producto_ofrecido_id: @product_one.id, producto_solicitado_id: @product_two.id,
mensaje: 'Test mensaje', estado: 0 } }
        end
      assert_redirected_to products_path
    end

    test "accept" do
        solicitud = solicituds(:solicitud_one)
      patch accept_solicitud_url(solicitud)
      assert_redirected_to rooms_path
    end

    test "reject" do
        solicitud = solicituds(:solicitud_one)
      patch reject_solicitud_url(solicitud)
      assert_redirected_to solicitudes_path
    end


    teardown do
        Rails.cache.clear
    end
end
