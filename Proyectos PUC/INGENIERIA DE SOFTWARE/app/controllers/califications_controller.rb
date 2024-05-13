class CalificationsController < ApplicationController
    def new
        @usuario_calificado = Usuario.find(params[:usuario_calificado_id])
      @usuario_calificador = Usuario.find(params[:usuario_calificador_id])
      @product = Product.find(params[:producto_id])
      @calification = Calification.new
    end

    def create
        @calification = Calification.new(calification_params)

      if @calification.save
          redirect_to root_path, notice: 'La calificación se ha guardado correctamente.'
      else
          flash[:error] = 'Hubo un error al guardar la calificación.'
        Rails.logger.error(@calification.errors.full_messages)
        render :new
      end
    end

  private

    def calification_params
        params.require(:calification).permit(:usuario_calificador_id, :usuario_calificado_id, :puntuacion, :mensaje,
                                             :product_id)
    end
end
