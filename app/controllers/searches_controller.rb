class SearchesController < ApplicationController
  def new
  end

  def create
    @flickr_user = FlickrApi.new(username: params[:search][:username])
    if !@flickr_user.valid?
      flash.now[:alert] = @flickr_user.errors.first 
    end
    render :new
  end
end