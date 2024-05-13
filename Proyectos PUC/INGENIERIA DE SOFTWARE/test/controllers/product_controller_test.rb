require "test_helper"

class ProductControllerTest < ActionDispatch::IntegrationTest
    fixtures :usuarios, :plataformas, :categorias, :regions, :products

    setup do
        @producto = products(:product_one)
      @categoria = categorias(:categoria_one)
      @plataforma = plataformas(:plataforma_one)
      @region = regions(:region_one)
      @usuario = usuarios(:usuario_one)
      @vendedor = usuarios(:usuario_two)

      sign_in @usuario
    end

    test "should get index" do
        get products_url
        assert_response :success
    end

    test "should get new" do
        get new_product_url
        assert_response :success
    end

    test "should show product" do
        get product_url(@producto)
        assert_response :success
    end

    test "should destroy product" do
        assert_difference("Product.count", -1) do
            delete product_url(@producto)
        end

      assert_nil Product.find_by(id: @producto.id)

      assert_redirected_to products_url
    end

    test "should show vendedor profile" do
        get vendedor_profile_product_path(@vendedor)
      assert_response :success
    end

    test "should get edit" do
        get edit_product_path(@producto.id)
      assert_response :success
    end

    test "get filter" do
        get filter_products_path, xhr: true,
params: { categoria_id: @categoria.id, plataforma_id: @plataforma.id, region_id: @region.id , format: :js}
      assert_response :success
    end

    teardown do
      # normalmente es buena idea resetear el cache
          Rails.cache.clear
      end
end
