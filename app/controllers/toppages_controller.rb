class ToppagesController < ApplicationController
  def index
    @photos = Photo.all.order(id: :desc).page(params[:page]).per(9)
  end
end
