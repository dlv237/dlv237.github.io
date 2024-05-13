module ApplicationHelper
    def bulma_class_for(flash_type)
        {
            :success => 'is-success',
            :error => 'is-danger',
            :alert => 'is-warning',
            :notice => 'is-info is-light'
        }   [flash_type.to_sym] || flash_type.to_s
    end
end
