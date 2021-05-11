class LikesController < ApplicationController
  def create
   @answer = Answer.find(params[:answer])
   current_user.like(@answer)
   flash[:success] = 'いいねしました'
  end

  def destroy
    @answer = Answer.find(params[:answer])
    current_user.unlike(@answer)
    flash[:success] = 'いいね解除しました'
  end
end