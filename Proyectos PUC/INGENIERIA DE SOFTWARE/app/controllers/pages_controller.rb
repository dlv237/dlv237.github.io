class PagesController < ApplicationController

    def home
        if admin_signed_in?
            redirect_to admin_root_path
        end
    end
end
