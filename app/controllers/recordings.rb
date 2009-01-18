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
    type = params["type"]
    label = params["label"]
    source = params["source"]
    lineage = params["lineage"]
    taper = params["taper"]
    year = params["year"]
    taper = params["taper"]
    venue_name = params["venue_name"]
    venue_city = params["venue_city"] 
    venue_state = params["venue_state"]
    options = {}
    unless type == 'all'
      options = options.merge({:type => type})
    end
    unless label == ''
      options = options.merge({:label.like => "%" << label << "%"})
    end
    unless source == ''
      options = options.merge({:source.like => "%" << source << "%"})
    end
    unless lineage == ''
      options = options.merge({:lineage.like => "%" << lineage << "%"})
    end
    unless taper == ''
      options = options.merge({:taper.like => "%" << taper << "%"})
    end
    unless year == 'All'
      options = options.merge({Recording.show.date_played.gte => year, Recording.show.date_played.lt => (year.to_i+1).to_s}) 
    end
    unless venue_name == ''
      options = options.merge({Recording.show.venue.venue_name.like => "%" << venue_name << "%"})
    end
    unless venue_city == ''
      options = options.merge({Recording.show.venue.venue_city.like => "%" << venue_city << "%"})
    end
    unless venue_state ==''
      options = options.merge({Recording.show.venue.venue_state.like => "%" << venue_state << "%"})
    end
    if options.empty?
      puts "test2"
      @recordings = Recording.all
    else
      puts "test"
      @recordings = Recording.all(:conditions => options)
    end
    render
  end
  
end