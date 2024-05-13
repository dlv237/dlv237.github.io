class Admin::ProductsController < Admin::AdminController
    def destroy_product
        @product = Product.find(params[:id])
        @product.destroy()
        redirect_back(fallback_location: root_path, notice: "Se ha eliminado #{@product.nombre}")
    end

    def index
        @products = Product.order(:id)
    end
end