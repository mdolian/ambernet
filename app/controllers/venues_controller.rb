class VenuesController < ApplicationController
  
  #before :ensure_authenticated, :only => [:admin, :new, :create, :edit, :delete, :update]
  attr_accessible :q, :venue_name, :venue_city, :venue_state
 
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
   
  def list
    venues = Venue.all(:conditions => ["venue_name LIKE  ?", "%" << params[:q] << "%"])
    list = ""
    venues.each do |venue|
      list << venue.venue_name << "\n"
    end
    render :json => list, :layout => false
  end
  
  def city_list 
    Venue.all(:conditions => ["venue_city LIKE ?", "%" << params["q"] << "%"], :select => "DISTINCT(venue_name)")
    list = ""
    venues.each do |venue|
      list << venue << "\n"
    end
    render :json => list, :layout => false
  end
  
end
