class ApplicationController < ActionController::Base
    layout :set_layout

    private

    def after_sign_in_path_for(_resource)
        if admin_signed_in?
            admin_root_path
        else
            root_path
        end
    end

    def set_layout
        if admin_signed_in?
            "admin"
        else
            "application"
        end
    end
end
