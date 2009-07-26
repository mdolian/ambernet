class VenuesController < ApplicationController
  
  # From Merb, to be implemented
  #before :ensure_authenticated, :only => [:admin, :new, :create, :edit, :delete, :update]
  #params_accessible :post => [:q, :venue_name, :venue_city, :venue_state]
 
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
    render :json => list, :layout => false
  end
  
  def city_list
    venues = repository(:default).adapter.query("SELECT DISTINCT venue_city FROM venues WHERE (`venue_city` LIKE '%" << params["q"] << "%')")
    
    #Venue.all(:conditions => {:venue_city.like => params["q"] << "%"})
    list = ""
    venues.each do |venue|
      list << venue << "\n"
    end
    render :json => list, :layout => false
  end
  
end
