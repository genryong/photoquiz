class AnswersController < ApplicationController
  
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
  
  private
  
  def answer_params
    params.require(:answer).permit(:content, :photo_id)
  end
end
