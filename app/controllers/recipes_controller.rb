class RecipesController < ApplicationController
    add_breadcrumb "Рецепти", :root_path

    def index
        @recipes = Recipe.moderated.order(created_at: :desc)
    end

    def new
        @categories = Category.all
        @recipe = Recipe.new

        add_breadcrumb "Новий рецепт", new_recipe_path
    end

    def create
        @recipe = Recipe.new(recipe_params)
        @recipe.user_id = current_user.id
        if @recipe.save
            flash[:success] = "Рецепт успішно створено!"
            redirect_to @recipe
        else
            error_message = @recipe.errors.full_messages.join(", ")
            flash[:error] = error_message
            render 'new'
        end
    end

    def show
        @recipe = Recipe.friendly.find(params[:id])
        if current_user && @recipe.user == current_user

        elsif @recipe.user.recipe_moderation == false
            return redirect_to root_path, alert: "Користувач на модерації"
        end

        add_breadcrumb "#{@recipe.title}", recipe_path
    end

    def edit
        @recipe = Recipe.find(params[:id])
        @categories = Category.all
    end

    def update
        @recipe = Recipe.find(params[:id])
        if @recipe.update(recipe_params)
            flash[:success] = "Рецепт успішно оновлено!"
            redirect_to @recipe
        else
            error_message = @recipe.errors.full_messages.join(",")
            flash[:error] = error_message
            redirect_to edit_recipe_path(@recipe)
        end
    end

    def destroy

    end

    private

    def recipe_params
        params.require(:recipe).permit(:title, :description, :ingredients, :image, :category_id, :user_id, recipe_steps_attributes: [:description, :position, :image])
    end
end