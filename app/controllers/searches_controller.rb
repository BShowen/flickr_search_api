class SearchesController < ApplicationController
  def new
  end

  def create
    @flickr_user = FlickrApi.new(username: params[:search][:username])
    apply_flash
    render :new
  end

  def show
    @img_source_url = FlickrApi.photo_url(params[:photo][:photo_data])
    
    #array of hashes of sizes for the given photo.
    @sizes = FlickrApi.photo_sizes(photo_id: params[:photo][:id])
  end

  private 
  def apply_flash
    if !@flickr_user.valid?
      flash.now[:danger] = "#{@flickr_user.errors.first}"
    elsif @flickr_user.valid? && @flickr_user.photos.empty?
      flash.now[:warning] = "Found #{@flickr_user.username.capitalize} but they don't seem to have any photos."
    else
      flash.now[:success] = "Showing photos for #{@flickr_user.username.capitalize}"
    end
  end
end