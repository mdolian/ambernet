class Recordings < Application

  before :ensure_authenticated

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
    unless params["type"] == 'all'
      options = options.merge({:type => params["type"]})
    end
    unless params["label"] == ''
      options = options.merge({:label.like => "%" << params["label"] << "%"})
    end
    unless params["source"] == ''
      options = options.merge({:source.like => "%" << params["source"] << "%"})
    end
    unless params["lineage"] == ''
      options = options.merge({:lineage.like => "%" << params["lineage"] << "%"})
    end
    unless params["taper"] == ''
      options = options.merge({:taper.like => "%" << params["taper"] << "%"})
    end
    unless params["year"] == 'All'
      options = options.merge({Recording.show.date_played.gte => params["year"], Recording.show.date_played.lt => (params["year"].to_i+1).to_s}) 
    end
    unless params["venue_name"] == ''
      options = options.merge({Recording.show.venue.venue_name.like => "%" << params["venue_name"] << "%"})
    end
    unless params["venue_city"] == ''
      options = options.merge({Recording.show.venue.venue_city.like => "%" << params["venue_city"] << "%"})
    end
    unless params["venue_state"] ==''
      options = options.merge({Recording.show.venue.venue_state.like => "%" << params["venue_state"] << "%"})
    end
    if options.empty? 
      message[:error] = "Please select at least one search filter"
      redirect "/recordings", :message => message
    else
      @recordings = Recording.all(:conditions => options)
      render
    end
  end
  
end