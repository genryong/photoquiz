class AnswersController < ApplicationController
  before_action :correct_user, only: [:destroy]
  before_action :require_user_logged_in
  
  
  def new
    @answer =Answer.new
    @photo = Photo.find(params[:photo_id])
  end
 
 
  def create
     @answer = current_user.answers.new(answer_params)
    if @answer.save
      flash[:success] = 'コメントしました。'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'コメントを入力してください。'
      redirect_back(fallback_location: root_path)
    end
  end
    
  def destroy
    @answer.destroy
    flash[:danger] = "コメントを削除しました。"
    redirect_back(fallback_location: root_path)
  end
  
  
  private
  
  def answer_params
    params.require(:answer).permit(:content, :photo_id)
  end
  
  def correct_user
    @answer = current_user.answers.find_by(id: params[:id])
    unless @answer
      redirect_to root_url
    end
  end
end
