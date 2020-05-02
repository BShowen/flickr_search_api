require_relative "flickr_api"

module ApplicationHelper
    def page_title(str)
        if str.empty?
            "Flickr Api"
        else
            "#{str} | Flickr Api"
        end
    end
end
