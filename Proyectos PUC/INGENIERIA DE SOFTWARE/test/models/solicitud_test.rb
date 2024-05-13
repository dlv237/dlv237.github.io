require "test_helper"

class SolicitudTest < ActiveSupport::TestCase
    def setup
        @product_one = products(:product_one)
      @product_two = products(:product_two)
    end

    test "Guardado bien" do
        @solicitud = Solicitud.new(estado: 1, producto_ofrecido:@product_one, mensaje: "mensaje estandar",
                                   producto_solicitado: @product_two)
      result = @solicitud.save
       assert result, " Falla en el guardado"
    end


    test "Should not save without producto_ofrecido" do
      @solicitud = Solicitud.new(estado: 1, producto_solicitado:@product_one, mensaje: "mensaje estandar")
      result = @solicitud.save
       assert_not result, "Saved the user withou a producto_ofrecido"
  end

    test "Should not save without producto_solicitado" do
        @solicitud = Solicitud.new(estado: 1, producto_ofrecido:@product_one, mensaje: "mensaje estandar")
      result = @solicitud.save
       assert_not result, "Saved the user withou a producto_solicitado"
    end

    test "Should not save without mensaje" do
        @solicitud = Solicitud.new(estado: 1, producto_ofrecido:@product_one, producto_solicitado:@product_two)
      result = @solicitud.save
       assert_not result, "Saved the user withou a mensaje"
    end

end
