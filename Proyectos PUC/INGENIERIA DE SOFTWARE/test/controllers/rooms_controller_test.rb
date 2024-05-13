require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
    setup do
          categoria = Categoria.new(nombre: "Estrategia")
      categoria.save
      plataforma = Plataforma.new(nombre: "PlayStation 2")
      plataforma.save
      rm = Region.new(nombre: "Región Metropolitana")
      rm.save
      usuario = Usuario.new(email:"pedro@gmail.com", nombre:"Pedro", password:"pedro123", region: rm)
      usuario.save
      @user = usuario
      sign_in @user
      end

    test "should get index" do
        get rooms_path
      assert_response :success
    end
end
