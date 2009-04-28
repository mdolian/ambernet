require 'date'

class Recordings < Application

  #before :ensure_authenticated, :only => [:admin, :new, :create, :edit, :delete, :update]
  
  params_accessible :post => [:label, :source, :lineage, :taper, :transfered_by, :notes, :type, :show_id, :page, :song_name, :filetype,
                              :year, :start_date, :end_date, :id, :submit, :venue_name, :venue_city, :venue_state, :submit, :shnid]
  
  def admin
    @current_page = (params[:page] || 1).to_i
    @page_count, @recordings = Recording.paginated(
      :page => @current_page,
      :per_page => 100)    
    render
  end
  
  def delete
    Recording.get(params["id"]).destroy
    @current_page = (params[:page] || 1).to_i
    @page_count, @recordings = Recording.paginated(
      :page => @current_page,
      :per_page => 100)    
    render :admin
  end
    
  def edit
    if params["submit"] == 'Update'
      tracking_info = params["discs"] << "["
      for i in (1..params["discs"].to_i) 
        tracking_info << params["tracksDisc" << i.to_s] << ","
      end
      tracking_info.chop! << "]"    
      @recording = Recording.get(params["id"])
      @recording.update_attributes( :label => params["label"],
                                    :source => params["source"],
                                    :lineage => params["lineage"],
                                    :taper => params["taper"],
                                    :transfered_by => params["transfered_by"],
                                    :notes => params["notes"],
                                    :type => params["type"],
                                    :filetype => params["filetype"],
                                    :shnid => params["shnid"],
                                    :tracking_info => tracking_info)                                                           
    else  
       @recording = Recording.get(params["id"])
    end
    render
  end
  
  def new
    render
  end

  def create
    tracking_info = params["discs"] << "["
    for i in (1..params["discs"].to_i)
      tracking_info << params["tracksDisc" << i.to_s] << ","
    end
    tracking_info.chop! << "]"    
    @recording = Recording.new(
      :show_id => params["show_id"],
      :label => params["label"],
      :source => params["source"] == "" ? "unknown" : params["source"],
      :lineage => params["lineage"] == "" ? "unknown" : params["lineage"],
      :taper => params["taper"] == "" ? "unknown" : params["taper"],
      :transfered_by => params["transfered_by"] == "" ? "unknown" : params["transfered_by"],
      :notes => params["notes"],
      :type => params["type"],
      :filetype => params["filetype"],
      :tracking_info => tracking_info
    )
    @recording.save
    @current_page = (params[:page] || 1).to_i
    @page_count, @recordings = Recording.paginated(
      :page => @current_page,
      :per_page => 100)    
    render :admin
  end  
    
  def choose_rec
    @recordings = Recording.all
    @action = params["id"]
    render
  end

  def index
    render
  end
 
  def stream
    provides :pls
    render Recording.get(params["id"]).to_pls, :layout => false 
  end
  
  def stream_by_date
    provides :pls
    date_played = Date.parse(params["date_played"])
    total_pls = ""
    Recording.all('show.date_played' => date_played.to_s).each do |recording|
      total_pls << recording.to_pls << "\n\n"
    end
    render total_pls.to_pls, :layout => false
  end
  
  def download
    @recording = Recording.get(params["id"])
  end 
  
  def show
    @recording = Recording.get(params["id"])
    @recording_tracks = RecordingTrack.all(:recording_id => params["id"])
    render
  end
  
  def search_results
    @current_page = (params[:page] || 1).to_i
    conditions = {}
    error_message = ""

    if params["submit"] != nil
      conditions.merge!({:type => params["type"]})                                                          if params["type"] != 'all'
      conditions.merge!({:shnid => params["shnid"]})                                                        if params["shnid"] != ''      
      conditions.merge!({:label.like => "%" << params["label"] << "%"})                                     if params["label"] != ''
      conditions.merge!({:source.like => "%" << params["source"] << "%"})                                   if params["source"] != ''
      conditions.merge!({:lineage.like => "%" << params["lineage"] << "%"})                                 if params["lineage"] != ''
      conditions.merge!({:taper.like => "%" << params["taper"] << "%"})                                     if params["taper"] != ''
      conditions.merge!({Recording.show.date_played.gte => params["year"], 
                                     Recording.show.date_played.lt => (params["year"].to_i+1).to_s})                    if params["year"] != 'All'
      conditions.merge!({Recording.show.venue.venue_name.like => "%" << params["venue_name"] << "%"})       if params["venue_name"] != ''
      conditions.merge!({Recording.show.venue.venue_city.like => "%" << params["venue_city"] << "%"})       if params["venue_city"] != ''
      conditions.merge!({Recording.show.venue.venue_state.like => "%" << params["venue_state"] << "%"})     if params["venue_state"] != ''
      #conditions.merge!({Recording.show.setlists.song.song_name.like => "%" << params["song_name"] << "%"}) if params["song_name"] != ''

      unless (params["end_date"] == '' && params["start_date"] == '')
        end_date = params["end_date"] == '' ? Date.today : Date.parse(params["end_date"])       
        start_date = params["start_date"] == '' ? Date.today : Date.parse(params["start_date"])
        error_message = "Start date later than end date" if (end_date < start_date)   
         
        conditions.merge!({Recording.show.date_played.gte => params["start_date"], 
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