require 'test_helper'

class Admin::ProductsControllerTest < ActionDispatch::IntegrationTest
    fixtures :admins, :products, :usuarios

    setup do
        @admin = admins(:admin_one)
        @product = products(:product_one)
        sign_in @admin
    end

    test "deberia eliminar producto" do
        assert_difference('Product.count', -1) do
            delete destroy_admin_product_path(@product)
        end
        assert_equal "Se ha eliminado #{@product.nombre}", flash[:notice]
    end

    teardown do
        Rails.cache.clear
    end
end
