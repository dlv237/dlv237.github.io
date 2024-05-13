class SolicitudController < ApplicationController
    before_action :authenticate_usuario!

    def index
        @solicitudes_enviadas = Solicitud.joins(:producto_ofrecido).where(products: { id_usuario: current_usuario.id })
        @solicitudes_recibidas = Solicitud.joins(:producto_solicitado)
                                          .where(products: { id_usuario: current_usuario.id })
    end

    def new
        @producto_ofrecido = Product.find(params[:id])
        @producto_solicitado = Product.find(params[:id])
        @solicitud = Solicitud.new
        @productos_usuario = Product.where(id_usuario: current_usuario.id)
    end

    def reject
        update_state(-1)
        redirect_to solicitudes_path, notice: "Se ha rechazado la solicitud"
    end

    def update_state(nuevo_estado)
        # Quizas hacer que no se pueda cambiar el estado si no esta en 0
        @solicitud = Solicitud.find(params[:id])
        @solicitud.update(estado: nuevo_estado)
    end

    def create
        @producto_ofrecido = Product.find(params[:solicitud][:producto_ofrecido_id])
        @producto_solicitado = Product.find(params[:solicitud][:producto_solicitado_id])
        @solicitud = Solicitud.create(producto_ofrecido: @producto_ofrecido, producto_solicitado: @producto_solicitado,
                                      mensaje: params[:solicitud][:mensaje], estado: 0)
        if @solicitud.save
            redirect_to products_path, notice: 'Se ha realizado la solicitud correctamente'
        else
            @producto_ofrecido = Product.find(params[:solicitud][:producto_ofrecido_id])
            @producto_solicitado = Product.find(params[:solicitud][:producto_solicitado_id])
            @productos_usuario = Product.where(id_usuario: current_usuario.id)
            render :new
        end
    end

    def accept
        @solicitud = Solicitud.find(params[:id])
        @producto_ofrecido = @solicitud.producto_ofrecido
        @producto_solicitado = @solicitud.producto_solicitado
        @usuario_1 = Usuario.find(@producto_ofrecido.id_usuario)
        @usuario_2 = Usuario.find(@producto_solicitado.id_usuario)
        @new_chat = Room.new(name: "Intercambio Nuevo Con - #{@usuario_2.nombre}", usuario_1: @usuario_1,
                             usuario_2: @usuario_2, is_private: true)
        if @new_chat.save
            flash[:notice] = "Se ha creado un chat para comunicarse con #{@usuario_2.nombre}."
            redirect_to rooms_url
            update_state(1)
            @producto_ofrecido.cambiar_estado('vendido')
            @producto_solicitado.cambiar_estado('vendido')
          else
              flash[:alert] = "Hubo un error al crear el chat."
            redirect_to solicitudes_path
          end
    end

    private

    def solicitud_params
        params.require(:solicitud).permit(:producto_solicitado_id, :producto_ofrecido_id, :mensaje, :estado)
    end
end