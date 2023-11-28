class Admin::RecipesController < AdminController
    before_action :set_recipe, only: [:show, :edit, :update, :destroy]

    def index
        @recipes = Recipe.moderated
        if params[:type] && params[:type] == 'unmoderated'
            @recipes = Recipe.unmoderated
        end
    end

    def show
    end

    def new
        @recipe = Recipe.new
    end

    def edit
        @recipe = Recipe.friendly.find(params[:id])
        @categories = Category.all
    end

    def create
        @recipe = Recipe.new(recipe_params)

        if @recipe.save
            redirect_to [:admin, @recipe], notice: 'Рецепт успішно створений'
        else
            render :new
        end
    end
    
    def publish
        @recipe = Recipe.friendly.find(params[:id])
        @recipe.user.update(recipe_moderation: true)
        redirect_to admin_recipes_path, notice: 'Рецепт опублікований'
    end

    def update
        if @recipe.update(recipe_params)
            redirect_to admin_recipes_path, notice: 'Рецепт успішно відредагований'
        else
            render :edit
        end
    end

    def destroy
        @recipe.destroy
        redirect_to admin_recipes_url, notice: 'Рецепт видалений'
    end

    private

    def set_recipe
        @recipe = Recipe.friendly.find(params[:id])
    end

    def recipe_params
        params.require(:recipe).permit(:title, :image, :description, :ingredients, :status, :category_id, :slug, recipe_steps_attributes: [:description, :position, :image])
    end
end