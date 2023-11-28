class UsersController < ApplicationController
    add_breadcrumb "Рецепти", :root_path

    def recipes
        @user = User.find(params[:id])
    end
    
    def favorites
        @user = current_user
        @favorite_recipes = @user.favorites.map(&:recipe)
    end

    def show
        @user = User.find_by(username: params[:id])
        add_breadcrumb "#{@user.username}", user_profile_path
    end
end