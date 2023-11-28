class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @recipe = Recipe.friendly.find(params[:recipe_id])
    @favorite = current_user.favorites.build(recipe: @recipe)
    if @favorite.save
      redirect_to @recipe, notice: 'Рецепт додано до обраного.'
    else
      redirect_to @recipe, alert: 'Не вдалося додати рецепт до обраного.'
    end
  end

  def destroy
    @recipe = Recipe.friendly.find(params[:recipe_id])
    @favorite = current_user.favorites.find_by(recipe: @recipe)
    if @favorite.destroy
      redirect_to @recipe, notice: 'Рецепт видалено з обраного.'
    else
      redirect_to @recipe, alert: 'Не вдалось видалити рецепт з обраного.'
    end
  end
end
