class Admin::CategoriesController < AdminController
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    def index
        @categories = Category.all
    end

    def show
    end

    def new
        @category = Category.new
    end

    def edit
    end

    def create
        @category = Category.new(category_params)

        if @category.save
            redirect_to [:admin, @category], notice: 'Категорія успішно создана'
        else
            render :new
        end
    end

    def update
        if @category.update(category_params)
            redirect_to [:admin, @category], notice: 'Категорія успішно відредагована'
        else
            render :edit
        end
    end

    def destroy
        @category.destroy
        redirect_to admin_categories_url, notice: 'Категорія видалена'
    end

    private

    def set_category
        @category = Category.find(params[:id])
    end

    def category_params
        params.require(:category).permit(:title, :image, :description, :parent_id)
    end
    
end