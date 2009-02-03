require 'show'
require 'date'
require 'dm-serializer'

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
    render list.to_json, :layout => false    
  end

  def setlist
    full_setlist = []
    setlists = Setlist.all(:show_id => params["id"], :order => [:set_id.asc, :song_order.asc])   
    setlists.each do |setlist|
      song = Song.get(setlist.song_id)
      full_setlist << {"set_id" => setlist.set_id, "song_order" => setlist.song_order, "song_name" => song.song_name, "segue" => setlist.song_suffix}
    end 
    render full_setlist.to_json, :layout => false
  end  

  def recordings
    render Recording.all(:conditions => {:show_id => params["id"]}).to_json, :layout => false
  end
    
  def search_results
    options = {}

    options = options.merge({Show.setlists.song.song_name.like => "%" << params["song_name"] << "%"}) if params["song_name"] != ''
    options = options.merge({:date_played.gte => params["year"], 
                             :date_played.lt => (params["year"].to_i+1).to_s})                        if params["year"] != 'All'
    options = options.merge({Show.venue.venue_city.like => "%" << params["venue_city"] << "%"})       if params["venue_city"] != ''
    options = options.merge({Show.venue.venue_state => "%" << params["venue_state"] << "%"})          if params["venue_state"] != ''
                  
    if options.empty? 
      message[:error] = "Please select at least one search filter"
      redirect "/shows", :message => message
    else 
      @shows = Show.all(:conditions => options)
      render
    end
  end   
 
end
