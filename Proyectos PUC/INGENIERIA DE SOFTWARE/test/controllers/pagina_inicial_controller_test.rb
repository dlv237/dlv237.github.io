require "test_helper"

class PaginaInicialControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
        rm = Region.new(nombre: "Región Metropolitana")
      rm.save
      usuario = Usuario.new(email:"pedro@gmail.com", nombre:"Pedro", password:"pedro123", region: rm)
      usuario.save
      @user = usuario
      sign_in @user
    end

    test "should get index" do
          get index_path
        assert_response :success
      end
end
