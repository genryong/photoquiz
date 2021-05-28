class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show edit update destroy ]
  before_action :correct_user, only: [:destroy, :edit]
  before_action :require_user_logged_in, only: [:show, :new, :edit, :destroy]
  
  
  def show
    @photo = Photo.find(params[:id])
    @answers = @photo.answers.order(id: :desc).page(params[:page]).per(10)
    @answer = current_user.answers.new
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos or /photos.json
  def create
    @photo = current_user.photos.new(photo_params)
    
    if @photo.save
      flash[:success] = '投稿に成功しました。'
      redirect_to root_path
    else
      flash.now[:danger] = "投稿に失敗しました。"
      render :new
    end
  end

  # PATCH/PUT /photos/1 or /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: "Photo was successfully updated." }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1 or /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "投稿を削除しました." }
      format.json { head :no_content }
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def photo_params
      params.require(:photo).permit(:image, :content)
    end
    
    def correct_user
      @photo = current_user.photos.find_by(id: params[:id])
      unless @photo
        redirect_to root_url
      end
    end
end
