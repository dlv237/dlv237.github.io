
class Admin::CalificationsController < Admin::AdminController
    def destroy_calification
        @calification = Calification.find(params[:id])
        @calification.destroy()
        redirect_back(fallback_location: root_path, notice: "Se ha eliminado la calificacion de
        #{@calification.usuario_calificador.nombre} sobre el videojuego
        #{@calification.product.nombre} de #{@calification.usuario_calificado.nombre}")
    end
end