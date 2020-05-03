![app screenshot](https://github.com/BShowen/flickr_search_api/blob/master/app/assets/images/example.png "some text")
# Flickr Viewer - [Go to app](https://flick-r.herokuapp.com/)

This is a simple application that allows you to type in the username for a Flickr user and see all of the photos they have uploaded. There are a few Flickr API gems out there such as [flickr.rb](https://github.com/RaVbaker/flickr/) and [flickraw](https://github.com/hanklords/flickraw), however this project was simple enough that I decided to create my own Flickr API. 

### How I communicate with the [Flickr API](https://www.flickr.com/services/api/)
The Flickr API is easy to understand. It takes in formatted url's and spits out the respone you asked for, in my case JSON. My own FlickrAPI creates an object everytime you create a new search. This object is associated with the user you're searching for and I can call methods on the object to retrieve information about the user. 

To see how my API in doing this just view the source code for it in app/helpers/flickr_api.rb or [right here](https://github.com/BShowen/flickr_search_api/blob/master/app/helpers/flickr_api.rb)
