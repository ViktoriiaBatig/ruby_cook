class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @recipe = Recipe.friendly.find(params[:recipe_id])
    existing_like = current_user.likes.find_by(recipe: @recipe)
    notice = "Вы поставили #{ params[:like][:like_type] }."

    if existing_like
        existing_like.update(like_params)
        redirect_to @recipe, notice: notice
    else
      @like = current_user.likes.build(like_params)
      if @like.save
        redirect_to @recipe, notice: notice
      end
    end
  end

  private

  def like_params
    params.require(:like).permit(:like_type).merge(recipe: @recipe)
  end

end
