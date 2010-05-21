class ShowsController < ApplicationController
 
  before_filter :authenticate_admin!, :except => [:search, :list, :setlist, :recordings, :show, :browse, :index, :browse_by] 
 
  def index
    @current_page = (params[:page] || 1).to_i 
    @shows = Show.paginate(:joins => :venue, :page => @current_page, :order => :date_played) 

    respond_to do |format|
      format.html
      format.xml  { render :xml => @shows }
    end
  end

  def show
    @show = Show.find(params["id"], :joins => [:venue, :setlists])
    @recordings = Recording.where("show_id = ?", @show.id).paginate(:page => (params[:page] || 1).to_i)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @show }
    end
  end 
 
  def new
    @show = Show.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @show }
    end
  end

  def edit
    @show = Show.find(params["id"])
  end

  def create 
    @show = Show.new(params[:show])

    respond_to do |format|
      if @show.save
        flash[:notice] = "Show was successfully created."
        format.html { redirect_to :action => "index" }
        format.xml  { render :xml => @show, :status => :created, :location => @show }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @show.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @show = Show.find(params["id"])
  
    respond_to do |format|
      if @show.update_attributes(params[:show])
        flash[:notice] = "Show was successfully updated."
        format.html { redirect_to :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @show.errors, :status => :unprocessable_entity }
      end
    end    
  end

  def destroy
    @show = Show.find(params[:id])
    @show.destroy

    respond_to do |format|
      flash[:notice] = "Show was successfully deleted."
      format.html { redirect_to :action => "index" }
      format.xml  { head :ok }
    end
  end

  def browse
    @current_page, error_message = (params[:page] || 1).to_i, ""

    if params["done"].nil?
      render
    else 
      @shows = Show.order("date_played desc").group("shows.id").joins(:venue, :setlists)
    
      if params["start_date"] != "" && params["end_date"] != ""
        end_date = params["end_date"] == '' ? Date.today : Date.parse(params["end_date"])
        start_date = params["start_date"] == '' ? Date.today : Date.parse(params["start_date"])
      
        error_message = "Start date later than end date" if (end_date < start_date)
        @shows = @shows.by_date start_date, end_date
      end  
    
      @shows = @shows.by_venues  params["as_values_venues"].chop!.split(",")    if params["as_values_venues"] != ""
      @shows = @shows.by_songs params["as_values_songs"].chop!.split(",")       if params["as_values_songs"] != ""
      @shows = @shows.by_recording_type params["recording_type"]                if params["recording_type"] != "all"

      @shows = @shows.paginate :all, :page => @current_page, :per_page => 25
      
      render :index
    end

  end
  
  def recordings
    @recordings = Recording.where("show_id = ?", params["id"]).paginate(:page => (params[:page] || 1).to_i)
    render :partial => 'recordings/list', :layout => false
  end
  
  # List of shows for auto complete in json format
  def list
    list = []
    shows = Show.where("date_played = ? ", params["date_played"])
    shows.each do |show|
      list << {"label" => show.label, "id" => show.id}
    end
    render :json => list.to_json, :layout => false
  end
 
  # Setlist for a show in json format
  def setlist
    setlist_json = []
    total_sets = Show.find(params["id"]).total_sets
    Show.find(params["id"]).setlists.each do |setlist|
      song = Song.find(setlist.song_id)
      setlist_json << {"set_id" => setlist.set_id, "song_order" => setlist.song_order, "song_name" => song.song_name, "segue" => setlist.song_suffix, "total_sets" => total_sets}
    end
    render :json => setlist_json.to_json, :layout => false
  end
 
private
  def sweep
    expire_fragment :action => [:show]
  end 
 
end