require "test_helper"

class RegionTest < ActiveSupport::TestCase
    test "Should not save without nombre" do
      @rm = Region.new(nombre: "")
      result = @rm.save
       assert_not result, "Saved the user withou a name"
  end

end
