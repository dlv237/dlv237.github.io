class Admin::UsuariosController < Admin::AdminController
    def index
        @usuarios = Usuario.order(:id)
    end

    def destroy
        @usuario = Usuario.find(params[:id])
        @usuario.destroy
        redirect_to admin_usuarios_path, notice: "Se ha eliminado el usuario #{@usuario.nombre}"
    end

    def ban
        @usuario = Usuario.find(params[:id])
        @usuario.update(locked_at: Time.current)
        redirect_to admin_usuarios_path, notice: "El usuario #{@usuario.nombre} ha sido baneado"
    end

    def unban
        @usuario = Usuario.find(params[:id])
        @usuario.update(locked_at: nil)
        redirect_to admin_usuarios_path, notice: "El usuario #{@usuario.nombre} ha sido desbaneado"
    end

    def index_usuario_products
        @usuario = Usuario.find(params[:id])
        @products = Product.where(id_usuario: params[:id])
    end

    def index_usuario_califications
        @usuario = Usuario.find(params[:id])
        @califications = Calification.where(usuario_calificador_id: params[:id])
    end
end