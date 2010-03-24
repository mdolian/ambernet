class VenuesController < ApplicationController

  #before_filter :authenticate_user!, :except => [:city_list, :list, :show] 
  
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
        flash[:notice] = "Venue was successfully created."
        format.html { redirect_to :action => "index" }
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
        flash[:notice] = "Venue was successfully updated."
        format.html { redirect_to :action => "index" }
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
      flash[:notice] = "Venue was successfully updated."
      format.html { redirect_to :action => "index" }
      format.xml  { head :ok }
    end
  end
  
  def list
    list = []
    venues = Venue.where("venue_name LIKE  ?", "%#{params[:q]}%")
    venues.each do |venue|
      list << {"label" => venue.venue_name, "id" => venue.id}
    end

    respond_to do |format|
      format.json { render :json => list.to_json, :layout => false }
    end

  end
  
  def city_list 
    list = []
    venues = Venue.where("venue_city LIKE ?", "%#{params["q"]}%").select("DISTINCT(venue_city)")
    venues.each do |venue|
      list << {"label" => venue.venue_city}
    end
    
    respond_to do |format|    
      format.json { render :json => list, :layout => false }
    end
  end
  
end
