class CommentsController < ApplicationController
    def create
      @recipe = Recipe.friendly.find(params[:recipe_id])
      @comment = @recipe.comments.new(comment_params)
      @comment.user = current_user
  
      if @comment.save
        redirect_to @recipe, notice: 'Комментар успішно додано.'
      else
        render 'recipes/show'
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:body, :image)
    end
end