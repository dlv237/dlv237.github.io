require 'test_helper'

class CalificationTest < ActiveSupport::TestCase
    def setup
        @calification = Calification.new(
          usuario_calificador_id: 1,  # Reemplaza con un ID válido si es necesario
          usuario_calificado_id: 2,  # Reemplaza con un ID válido si es necesario
          puntuacion: 5,
          mensaje: "Excelente",
          product_id: 1  # Reemplaza con un ID válido si es necesario
      )
    end


    test "usuario_calificador_id should be present" do
        @calification.usuario_calificador_id = nil
      assert_not @calification.valid?
    end

    test "usuario_calificado_id should be present" do
        @calification.usuario_calificado_id = nil
      assert_not @calification.valid?
    end

    test "puntuacion should be present" do
        @calification.puntuacion = nil
      assert_not @calification.valid?
    end

    test "mensaje should be present" do
        @calification.mensaje = "   "
      assert_not @calification.valid?
    end

    test "mensaje should not be too long" do
        @calification.mensaje = "a" * 1001  # Ajusta el límite según tus requisitos
      assert_not @calification.valid?
    end

    test "product_id should be present" do
        @calification.product_id = nil
      assert_not @calification.valid?
    end
end
