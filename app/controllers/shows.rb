require 'show'
require 'date'

class Shows < Application
  before :ensure_authenticated

  def index
    render
  end
  
  def list
    list = []    
    shows = Show.all(:date_played.eql => Date.strptime(params["date_played"]))
    shows.each do |show|
      list << {"label" => show.label, "id" => show.id}
    end
    content_type = :json
    render list.to_json, :layout => false    
  end

  def setlist
    full_setlist = []
    setlists = Setlist.all(:show_id => params["id"], :order => [:set_id.asc, :song_order.asc])   
    setlists.each do |setlist|
      song = Song.get(setlist.song_id)
      full_setlist << {"set_id" => setlist.set_id, "song_order" => setlist.song_order, "song_name" => song.song_name, "segue" => setlist.song_suffix}
    end 
    content_type = :json
    render full_setlist.to_json, :layout => false
  end  
  
  def search_results
    options = {}
    year = params["year"]
    song_name = params["song_name"]
    venue_city = params["venue_city"]
    venue_state = params["venue_state"]
    unless song_name == ''
      options = options.merge({Show.setlists.song.song_name.like => "%" << song_name << "%"})
    end
    unless year == 'All'
      options = options.merge({:date_played.gte => year, :date_played.lt => (year.to_i+1).to_s})
    end
    unless venue_city == ''
      options = options.merge({Show.venue.venue_city.like => "%" << venue_city << "%"})
    end
    unless venue_state == ''
      options = options.merge({Show.venue.venue_state => "%" << venue_state << "%"})
    end
    if options.empty? 
      @shows = Show.all 
    else 
      @shows = Show.all(:conditions => options)
    end
    render
  end
      
  def recordings
    begin
      @recordings = Recording.all(:conditions => {:show_id => params["id"]})
    rescue
      @message = {:notice => "No recordings exist"}
    end
    render :layout => false
  end
end
