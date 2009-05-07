require 'date'
require 'dm-serializer'

class Shows < Application

  before :ensure_authenticated, :only => [:admin, :new, :create, :edit, :delete, :update]
  
  params_accessible :post => [:date_played, :sid, :page, :year, :start_date, :end_date, :submit,
                              :venue_name, :venue_city, :venue_state, :song_name, :method]


  def index
    render :layout => false
  end
  
  def list
    list = []    
    shows = Show.all(:date_played.eql => Date.strptime(params["date_played"]))
    shows.each do |show|
      list << {"label" => show.label, "id" => show.id}
    end
    render list.to_json, :layout => false    
  end

  def setlist
    setlist_json = []
    total_sets = Show.get(params["id"]).setlists[0].total_sets
    Show.get(params["id"]).setlists.each do |setlist|
      song = Song.get(setlist.song_id)
      setlist_json << {"set_id" => setlist.set_id, "song_order" => setlist.song_order, "song_name" => song.song_name, "segue" => setlist.song_suffix, "total_sets" => total_sets}
    end     
    render setlist_json.to_json, :layout => false
  end  

  def recordings
    render Recording.all(:conditions => {:show_id => params["id"]}).to_json, :layout => false
  end
    
  def search_results
    @current_page = (params[:page] || 1).to_i
    conditions = {}
    error_message, notice_message = "",""
    
    if params["submit"] != nil
      conditions.merge!({Show.setlists.song.song_name.like => "%" << params["song_name"] << "%"})     if params["song_name"] != ''
      conditions.merge!({:date_played.gte => params["year"], 
                         :date_played.lt => (params["year"].to_i+1).to_s})                            if params["year"] != 'All'
      conditions.merge!({Show.venue.venue_city.like => "%" << params["venue_city"] << "%"})           if params["venue_city"] != ''
      conditions.merge!({Show.venue.venue_state => "%" << params["venue_state"] << "%"})              if params["venue_state"] != ''
      conditions.merge!({Show.venue.venue_name.like => "%" << params["venue_name"] << "%"}) if params["venue_name"] != ''

      unless (params["end_date"] == '' && params["start_date"] == '')
        end_date = params["end_date"] == '' ? Date.today : Date.parse(params["end_date"])       
        start_date = params["start_date"] == '' ? Date.today : Date.parse(params["start_date"])
        error_message = "Start date later than end date" if (end_date < start_date)   
        conditions.merge!({:date_played.gte => start_date, :date_played.lte => end_date})      
      end
    else
      conditions = session[:conditions]
    end 
    
    error_message = "Please select at least one search filter" if conditions.empty? 
    
    @page_count, @shows = Show.paginated(
      :page => @current_page,
      :per_page => 50,
      :conditions => conditions,
      :order => [:date_played.asc])             if error_message == ''
    session[:conditions] = conditions           if error_message == ''
    session[:searchBranch] = "shows"            if error_message == '' 
    session[:current_page] = @current_page      if error_message == ''             
    message[:error] = error_message             if error_message != ''
    message[:notice] = notice_message           if notice_message != ''    
    render :layout => false

  end   
 
end
