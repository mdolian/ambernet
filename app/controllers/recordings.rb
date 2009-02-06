require 'date'

class Recordings < Application

  #before :ensure_authenticated

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
    options = {}
    error_message = ""
            
    options = options.merge({:type => params["type"]})                                                      if params["type"] != 'all'
    options = options.merge({:label.like => "%" << params["label"] << "%"})                                 if params["label"] != ''
    options = options.merge({:source.like => "%" << params["source"] << "%"})                               if params["source"] != ''
    options = options.merge({:lineage.like => "%" << params["lineage"] << "%"})                             if params["lineage"] != ''
    options = options.merge({:taper.like => "%" << params["taper"] << "%"})                                 if params["taper"] != ''
    options = options.merge({Recording.show.date_played.gte => params["year"], 
                             Recording.show.date_played.lt => (params["year"].to_i+1).to_s})                if params["year"] != 'All'
    options = options.merge({Recording.show.venue.venue_name.like => "%" << params["venue_name"] << "%"})   if params["venue_name"] != ''
    options = options.merge({Recording.show.venue.venue_city.like => "%" << params["venue_city"] << "%"})   if params["venue_city"] != ''
    options = options.merge({Recording.show.venue.venue_state.like => "%" << params["venue_state"] << "%"}) if params["venue_state"] != ''


    unless (params["end_date"] == '' && params["start_date"] == '')
      end_date = params["end_date"] == '' ? Date.today : Date.parse(params["end_date"])       
      start_date = params["start_date"] == '' ? Date.today : Date.parse(params["start_date"])
      error_message = "Start date later than end date" if (end_date < start_date)   
         
      options = options.merge({Recording.show.date_played.gte => params["start_date"], 
                               Recording.show.date_played.lte => params["end_date"]})      
    end
    
    error_message = "Please select at least on search filter" if options.empty?    
    
    if error_message == ''
      @recordings = Recording.all(:conditions => options)
      render      
    else 
      message[:error] = error_message
      redirect "/recordings", :message => message
    end    

  end
  
end