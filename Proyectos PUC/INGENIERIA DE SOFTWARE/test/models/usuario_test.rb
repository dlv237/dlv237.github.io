require "test_helper"

class UsuarioTest < ActiveSupport::TestCase

    test "Should not save without nombre" do
       rm = Region.new(nombre: "Región Metropolitana")
       rm.save
        @usuario = Usuario.new(email:"pedro@gaadmail.com", nombre:"", password:"pedro123", region: rm)
        result = @usuario.save
        assert_not result, "Saved the user withou a name"
   end

    test "Should not save without email" do
     rm = Region.new(nombre: "Región Metropolitana")
     rm.save
     @usuario = Usuario.new(email:"", nombre:"pedrou", password:"pedro123", region: rm)
     result = @usuario.save
     assert_not result, "Saved the user withou a email"
 end


    test "Should not save without region" do
      rm = Region.new(nombre: "Región Metropolitana")
      rm.save
      @usuario = Usuario.new(email:"pedro@gaadmail.com", nombre:"pedrou", password:"pedro123")
      result = @usuario.save
      assert_not result, "Saved the user withou a region"
  end
    teardown do
      # normalmente es buena idea resetear el cache
          Rails.cache.clear
      end
end
