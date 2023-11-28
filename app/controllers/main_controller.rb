class MainController < ApplicationController
    def index
        @categories = Category.includes(:subcategories).where(parent_id: nil)
        @users = User.all

        @recipes = Recipe.moderated.order(created_at: :desc)
    end
end