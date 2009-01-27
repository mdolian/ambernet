class Venues < Application
  before :ensure_authenticated
 
  def index
    render
  end
  
  def list
    venues = Venue.all(:conditions => {:venue_name.like => params["q"] << "%"})
    list = ""
    venues.each do |venue|
      list << venue.venue_name << " "
    end
    render list, :layout => false
  end
  
  def city_list
    venues = Venue.all(:conditions => {:venue_city.like => params["input_content"] << "%"})
    list = ""
    venues.each do |venue|
      list << venue.venue_city
    end
    render list, :logout => false
  end
  
end
