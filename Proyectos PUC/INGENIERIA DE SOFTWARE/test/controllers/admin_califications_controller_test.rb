require 'test_helper'

class Admin::CalificationsControllerTest < ActionDispatch::IntegrationTest
    fixtures :admins, :califications

    setup do
        @admin = admins(:admin_one)
        @calification = califications(:calification_one)
        sign_in @admin
    end

    test "deberia eliminar calificacion" do
        assert_difference('Calification.count', -1) do
            delete destroy_admin_calification_path(@calification)
        end
        assert_equal "Se ha eliminado la calificacion de
        #{@calification.usuario_calificador.nombre} sobre el videojuego
        #{@calification.product.nombre} de #{@calification.usuario_calificado.nombre}", flash[:notice]
    end

    teardown do
        Rails.cache.clear
    end
end
