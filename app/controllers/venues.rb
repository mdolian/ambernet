class Venues < Application
  
  #before :ensure_authenticated, :only => [:admin, :new, :create, :edit, :delete, :update]
 
  params_accessible :post => [:q, :venue_name, :venue_city, :venue_state]
 
  def admin
    render
  end
  
  def new
    render
  end
  
  def create
    @venue = Venue.new(
      :venue_name => params["venue_name"],
      :venue_city => params["venue_city"],
      :venue_state => params["venue_state"]
    )
    @venue.save
    render :admin
  end
 
  def index
    render
  end
  
  def list
    venues = Venue.all(:conditions => {:venue_name.like => params["q"] << "%"})
    list = ""
    venues.each do |venue|
      list << venue.venue_name << "\n"
    end
    render list, :layout => false
  end
  
  def city_list
    venues = Venue.all(:conditions => {:venue_city.like => params["q"] << "%"})
    list = ""
    venues.each do |venue|
      list << venue.venue_city << "\n"
    end
    render list, :logout => false
  end
  
end
