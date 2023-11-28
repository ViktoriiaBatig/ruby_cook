class AdminController < ApplicationController
    layout 'admin'

    before_action :check_admin

    private

    def check_admin
        redirect_to root_path, alert: 'У вас немає прав доступу' unless current_user && current_user.admin?
    end
end