require 'show'

class Shows < Application

  def index
    render
  end
  
  def search_results
    options = {}
    venue_id = params["venue_id"]
    year = params["year"]
    unless venue_id == 'All'
      options = options.merge({'venue.id' => params["venue_id"]})
    end
    unless year == 'All'
      options = options.merge({:date_played.gte => params['year'], :date_played.lt => (params['year'].to_i+1).to_s})
    end
    @shows = Show.all(:conditions => options)
    render
  end
  
end
