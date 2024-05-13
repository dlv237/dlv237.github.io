require "test_helper"

class PlataformaTest < ActiveSupport::TestCase
    test "Should not save without nombre" do
      @plataforma = Plataforma.new(nombre: "")
      result = @plataforma.save
       assert_not result, "Saved the user withou a name"
  end

end