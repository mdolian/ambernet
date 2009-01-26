class Venues < Application
  before :ensure_authenticated
  provides :json
 
  def index
    render
  end
  
  def list
    venues = Venue.all(:conditions => {:venue_name.like => params["input_content"] << "%"})
    list = []
    venues.each do |venue|
      list << venue.venue_name
    end
    render list.uniq.sort.to_json, :layout => false
  end
  
  def city_list
    venues = Venue.all(:conditions => {:venue_city.like => params["input_content"] << "%"})
    list = []
    venues.each do |venue|
      list << venue.venue_city
    end
    render list.uniq.sort.to_json, :logout => false
  end
  
end
