class Admin::AdminController < ApplicationController
    before_action :authenticate_admin!

    def home
    end

    private

    def authenticate_admin!
        unless admin_signed_in?
            redirect_to root_path, alert: "Acceso denegado"
        end
    end
end
