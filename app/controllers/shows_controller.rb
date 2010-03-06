class ShowsController < ApplicationController
 
  #before_filter :authenticate_user!, :except => [:search, :list, :setlist, :recordings, :show] 
 
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
  
  # List of shows for auto complete in json format
  def list
    list = []
    shows = Show.all(:conditions => ["date_played = ? ", params["date_played"]])
    shows.each do |show|
      list << {"label" => show.label, "id" => show.id}
    end
    render :json => list.to_json, :layout => false
  end
 
  # Setlist for a show in json format
  def setlist
    setlist_json = []
    total_sets = Show.find(params["id"]).setlists[0].total_sets
    Show.find(params["id"]).setlists.each do |setlist|
      song = Song.find(setlist.song_id)
      setlist_json << {"set_id" => setlist.set_id, "song_order" => setlist.song_order, "song_name" => song.song_name, "segue" => setlist.song_suffix, "total_sets" => total_sets}
    end
    render :json => setlist_json.to_json, :layout => false
  end
 
  # List recordings for a show
  def recordings
    @recordings = Recording.all(:show_id => params["id"])
    render :layout => false
  end
 
end