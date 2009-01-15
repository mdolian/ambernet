class Venues < Application
  provides :json
 
  def index
    render
  end
  
  def list
    q = params["input_content"] << "%"
    @venues = Venue.all(:conditions => {:venue_name.like => q})
    #display @venues
    list = Array.new
    @venues.each do |venue|
      list << venue.venue_name
    end
    list.uniq!
    list.sort!
    content_type = :json
    render list.to_json, :layout => false
  end
  
  def city_list
    q = params["input_content"] << "%"
    @venues = Venue.all(:conditions => {:venue_city.like => q})
    list = Array.new
    @venues.each do |venue|
      list << venue.venue_city
    end
    list.uniq!
    list.sort!
    content_type = :json
    render list.to_json, :logout => false
  end
  
end
