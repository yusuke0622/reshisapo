class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_icon])
    end
    
    def after_sign_in_path_for(resource)
        user_path(current_user.id)
    end
    
    def after_sign_out_path_for(resource)
        new_user_session_path
    end
    
    #フラッシュメッセージkey追加
    def bootstrap_alert(key)
        case key
        when "alert"
          "warning"
        when "notice"
          "success"
        when "error"
          "danger"
        end
    end
    
end
