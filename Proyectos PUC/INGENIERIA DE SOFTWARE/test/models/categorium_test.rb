require "test_helper"

class CategoriumTest < ActiveSupport::TestCase
    test "Should not save without nombre" do
      @cat = Categoria.new(nombre: "")
      result = @cat.save
       assert_not result, "Saved the user withou a name"
  end

end
