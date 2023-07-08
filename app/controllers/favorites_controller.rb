class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(user_id: current_user.id, book_id: params[:book_id])
    @favorite.save
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
    @favorite.destroy if @favorite.present?
  end
end