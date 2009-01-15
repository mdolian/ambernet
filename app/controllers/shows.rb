require 'show'

class Shows < Application
 # before :ensure_authenticated

  def index
    render
  end
  
  def list
    q = params["input_content"] << "%"
    @shows = Show.all(:conditions => {:date_played.like => q})
    list = Array.new
    @shows.each do |show|
      list << show.label
    end
    list.uniq!
    list.sort!
    content_type = :json
    render list.to_json, :layout => false    
  end
  
  def search_results
    options = {}
    venue_id = params["venue_id"]
    year = params["year"]
    song_name = params["song_name"]
    venue_city = params["venue_city"]
    venue_state = params["venue_state"]
    unless venue_id == 'All'
      options = options.merge({'venue.id' => venue_id})
    end
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
  
  def setlist
    @show = Show.get(params["id"])
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
