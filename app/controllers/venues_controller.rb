class VenuesController < ApplicationController
  
  def index
    @current_page = (params[:page] || 1).to_i 
    @venues = Venue.paginate(:page => @current_page, :per_page => 100, :order => :venue_name) 

    respond_to do |format|
      format.html
      format.xml  { render :xml => @venues }
    end
  end

  def show
    @venue = Venue.find(params["id"])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @venue }
    end
  end 
 
  def new
    @venue = Venue.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @venue }
    end
  end

  def edit
    @venue = Venue.find(params["id"])
  end

  def create 
    @venue = Venue.new(params[:venue])

    respond_to do |format|
      if @venue.save
        format.html { redirect_to(:action => "index", :notice => 'Venue was successfully created.') }
        format.xml  { render :xml => @venue, :status => :created, :location => @venue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @venue = Venue.find(params["id"])
  
    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        format.html { redirect_to(:action => "index", :notice => 'Venue was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end    
  end

  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy

    respond_to do |format|
      format.html { redirect_to :action => "index" }
      format.xml  { head :ok }
    end
  end
  
  def list
    venues = Venue.all(:conditions => ["venue_name LIKE  ?", "%" << params[:q] << "%"])
    list = ""
    venues.each do |venue|
      list << venue.venue_name << "\n"
    end
    
    responds_to do |format|
      format.json { render :json => list, :layout => false }
    end
  end
  
  def city_list 
    venues = Venue.all(:conditions => ["venue_city LIKE ?", "%" << params["q"] << "%"], :select => "DISTINCT(venue_name)")
    list = ""
    venues.each do |venue|
      list << venue << "\n"
    end
    
    responds_to do |format|    
      format.json { render :json => list, :layout => false }
    end
  end
  
end
