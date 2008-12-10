require 'show'

class Shows < Application

  def index
    render
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
      options = options.merge({'setlists.song.song_name' => song_name})
    end
    unless year == 'All'
      options = options.merge({:date_played.gte => params['year'], :date_played.lt => (params['year'].to_i+1).to_s})
    end
    unless venue_city == ''
      options = options.merge({'venue.venue_city' => venue_city})
    end
    unless venue_state == ''
      options = options.merge({'venue.venue_state' => venue_state})
    end
    if options.empty? 
      @shows = Show.all
    else
      puts "full"
      @shows = Show.all(:conditions => options)
    end
    #@shows = Show.all(:links => {:setlists}, Show.setlists.song.song_name)
    render
  end
  
  def setlist
    @shows = Show.get(params["id"])
    render
  end
end
