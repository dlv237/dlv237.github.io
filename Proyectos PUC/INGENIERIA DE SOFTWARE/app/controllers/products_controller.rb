class ProductsController < ApplicationController
      #GET /prodductos
    skip_before_action :verify_authenticity_token, only: :filter
    before_action :authenticate_usuario!

    def index
        @product = Product.all
        @categorias = Categoria.all
        @plataformas = Plataforma.all

        if params[:region_id].present?
            @products = @products.joins(usuario: :region).where('usuarios.region_id = ?', params[:region_id])

        end
        @regions = Region.all
    end

    def show
        @product = Product.find(params[:id])
        @usuario = @product.usuario
    end

    def new
        @product = Product.new
    end

    def vendedor_profile
        @vendedor = Usuario.find(params[:id])
      @products = Product.find_by_sql(["SELECT * FROM products WHERE id_usuario = ?", @vendedor.id])
      @califications = Calification.find_by_sql(["SELECT * FROM califications WHERE usuario_calificado_id = ?",
                                                 @vendedor.id])
    end

    def edit
        @product = Product.find(params[:id])
        @categorias = Categoria.all
        @plataformas = Plataforma.all

        if @product.usuario != current_usuario
            flash[:alert] = "No tienes permiso para editar esta publicación."
          redirect_to products_path
        end
    end

    #POST /products
    def create
        @product = Product.new(products_params)
      @product.id_usuario = current_usuario.id
      @product.estado = "publicado"

      if @product.save
          redirect_to @product

      else
          render :new, status: :unprocessable_entity
      end
    end

    def filter
        categoria_id = params[:categoria_id]
      plataforma_id = params[:plataforma_id]
      region_id = params[:region_id]
      nombre = params[:search]

      @product = Product.all

      if nombre.present?
          @product = @product.where('nombre ILIKE ?', "%#{nombre}%")
      end

      if categoria_id != 'all'
          @product = @product.where(categoria_id: categoria_id)
      end

      if plataforma_id != 'all'
          @product = @product.where(plataforma_id: plataforma_id)
      end

      if region_id != 'all'
          @product = @product.joins(usuario: :region).where('usuarios.region_id = ?', region_id)
      end

      respond_to do |format|
          format.js
      end
    end

    def update
        @product = Product.find(params[:id])
      if @product.update(products_params)
          flash[:notice] = "Publicación actualizada correctamente."
        redirect_to @product
      else
          render :edit
      end
    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy
        redirect_to products_url
    end

    private
    def products_params
        params.require(:product).permit(:nombre, :descripcion, :estado, :image, :categoria_id, :plataforma_id)
    end

end
