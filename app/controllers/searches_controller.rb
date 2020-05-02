class SearchesController < ApplicationController
  def new
  end

  def show
  end

  def create
    @flickr_user = FlickrApi.new(username: params[:search][:username])
    if !@flickr_user.valid?
      flash[:alert] = @flickr_user.errors.first 
    end
    render "searches/show.html.erb"
  end

end