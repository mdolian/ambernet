class Venues < Application
  provides :json
 
  def index
    render
  end
  
  def list
    q = params["q"] << "%"
    @venues = Venue.all(:conditions => {:venue_name.like => q})
    #display @venues
    list = ""
    @venues.each do |venue|
      list << venue.venue_name << "<br>"
    end
    content_type = :json
    render list, :layout => false
  end
  
end
