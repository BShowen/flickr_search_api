require "JSON"
require "net/http"

class UserError < StandardError; end
class InitializeError < StandardError; end

class FlickrApi
  attr_reader :user_id, :username, :photos
  
  def initialize(options = {})
    @api_key = ENV["FLICKR_API_KEY"]
    raise InitializeError,  "username is required" if options[:username].nil?
    begin
      @username = options[:username] 
      raise UserError, "Name cant be blank" if @username.blank?
    rescue UserError => e
      errors << e.message
    end
    @user_id = get_user_id if !@username.blank?
    @photos = get_photos if @user_id
  end

  def valid?
    @errors.nil?
  end

  def photo_url(options = {})
    farm_id = options["farm"]
    server_id = options["server"]
    id = options["id"]
    secret = options["secret"]
    full_photo_url = "https://farm#{farm_id}.staticflickr.com/#{server_id}/#{id}_#{secret}.jpg"
  end

  # errors will be accumulated into this array. The object will be invalid unless errors is empty. 
  def errors
    @errors ||= []
  end

  private
  # fetches the user_id for the given username. This method responds with the user_id
  def get_user_id
    begin
      id_url ||= URI("https://www.flickr.com/services/rest/?method=flickr.people.findByUsername&api_key=#{@api_key}&username=#{@username}&format=json&nojsoncallback=1")
      id_response ||= Net::HTTP.get(id_url)
      @parsed_id_response ||= JSON.parse(id_response) 
      raise UserError, "Cant find user #{@username.capitalize}" if @parsed_id_response["stat"] != "ok"
    rescue UserError => e
      errors << e.message
      return
    end
    @parsed_id_response["user"]["id"] 
  end

  # fetches the photos for the given user. This method reponds with a JSON hash. 
  def get_photos
    photos_url = URI("https://www.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&api_key=#{@api_key}&user_id=#{@user_id}&format=json&nojsoncallback=1")
    @photos_response ||= Net::HTTP.get(photos_url)
    @parsed_photos_response ||= JSON.parse(@photos_response)["photos"]["photo"]
  end
end