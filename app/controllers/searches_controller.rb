class SearchesController < ApplicationController
  def new
  end

  def show
  end

  def create
    @flickr_user = FlickrApi.new(username: params[:search][:username])
    if !@flickr_user.valid?
      flash.now[:alert] = @flickr_user.errors.first 
      render :new
    else
      render :show
    end
  end

end