class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(user_id: current_user.id, book_id: params[:book_id])
    @favorite.save
    redirect_to request.referer
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
    @favorite.destroy if @favorite.present?
    redirect_to request.referer
  end
end
