require 'show'

class Shows < Application

  def index
    render
  end
  
  def search
    @venues - Venue.all
  end
  
  def search_results
    options = {:date_played.gte => params['year'], :date_played.lt => (params['year'].to_i+1).to_s}
    if !params["venue_name"].empty?
      options = {:date_played.gte => params['year'], :date_played.lt => (params['year'].to_i+1).to_s, 'venue.venue_name' => params["venue_name"]}
    end
    @shows = Show.all(:conditions => options)
    render
  end
  
end
