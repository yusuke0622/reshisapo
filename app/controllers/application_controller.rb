class ApplicationController < ActionController::Base
    def configure_permitted_parameters
        devise_parameter_sanitaizer.permit(:sign_up, keys: [:name, :user_icon])
    end
end
