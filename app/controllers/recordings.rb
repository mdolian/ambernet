require 'date'

class Recordings < Application

  #before :ensure_authenticated
  params_accessible :post => [:label, :source, :lineage, :taper, :transfered_by, :notes, :type, :show_id, :page, :song_name,
                              :year, :start_date, :end_date, :id, :submit, :venue_name, :venue_city, :venue_state]
  
  def admin
    render
  end
  
  def delete
    Recording.delete(params["id"])
    render
  end
  
  def edit
    if params["submit"] == 'Update'
      @recording = Recording.get(params["id"])
      @recording.update_attributes( :label => params["label"],
                                    :source => params["source"],
                                    :lineage => params["lineage"],
                                    :taper => params["taper"],
                                    :transfered_by => params["transfered_by"],
                                    :notes => params["notes"],
                                    :type => params["type"] )
      render
    else  
       @recording = Recording.get(params["id"])
    end
    render
  end
  
  def choose_rec
    @recordings = Recording.all
    @action = params["id"]
    render
  end

  def index
    render
  end
  
  def show
    @recording = Recording.get(params["id"])
    @recording_tracks = RecordingTrack.all(:recording_id => params["id"])
    render
  end
  
  def new
    render
  end
  
  def create
    show = Show.get(params["show_id"])
    @recording = Recording.new(
      :show_id => params["show_id"],
      :label => params["label"],
      :source => params["source"],
      :lineage => params["lineage"],
      :taper => params["taper"],
      :transfered_by => params["transferred_by"],
      :notes => params["notes"],
      :type => params["type"]
    )
    @recording.save
    render :admin
  end
  
  def search_results
    @current_page = (params[:page] || 1).to_i
    conditions = {}
    error_message = ""
            
    if params["method"] == "post"
      conditions = conditions.merge({:type => params["type"]})                                                          if params["type"] != 'all'
      conditions = conditions.merge({:label.like => "%" << params["label"] << "%"})                                     if params["label"] != ''
      conditions = conditions.merge({:source.like => "%" << params["source"] << "%"})                                   if params["source"] != ''
      conditions = conditions.merge({:lineage.like => "%" << params["lineage"] << "%"})                                 if params["lineage"] != ''
      conditions = conditions.merge({:taper.like => "%" << params["taper"] << "%"})                                     if params["taper"] != ''
      conditions = conditions.merge({Recording.show.date_played.gte => params["year"], 
                                     Recording.show.date_played.lt => (params["year"].to_i+1).to_s})                    if params["year"] != 'All'
      conditions = conditions.merge({Recording.show.venue.venue_name.like => "%" << params["venue_name"] << "%"})       if params["venue_name"] != ''
      conditions = conditions.merge({Recording.show.venue.venue_city.like => "%" << params["venue_city"] << "%"})       if params["venue_city"] != ''
      conditions = conditions.merge({Recording.show.venue.venue_state.like => "%" << params["venue_state"] << "%"})     if params["venue_state"] != ''
      #conditions = conditions.merge({Recording.show.setlists.song.song_name.like => "%" << params["song_name"] << "%"}) if params["song_name"] != ''

      unless (params["end_date"] == '' && params["start_date"] == '')
        end_date = params["end_date"] == '' ? Date.today : Date.parse(params["end_date"])       
        start_date = params["start_date"] == '' ? Date.today : Date.parse(params["start_date"])
        error_message = "Start date later than end date" if (end_date < start_date)   
         
        conditions = conditions.merge({Recording.show.date_played.gte => params["start_date"], 
                                       Recording.show.date_played.lte => params["end_date"]})      
      end
    else
      conditions = session[:conditions]
    end
    
    error_message = "Please select at least on search filter" if conditions.empty?  
    
    @page_count, @recordings = Recording.paginated(
      :page => @current_page,
      :per_page => 100,
      :conditions => conditions)                              if error_message == ''    
    session[:conditions] = conditions                         if error_message == ''  
    message[:error] = error_message                           if error_message != ''
    render

  end
  
end