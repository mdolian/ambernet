require 'show'

class Shows < Application

  def index
    render
  end
  
  def search
    @shows = Show.all(:conditions => {:date_played.gte => params['year'], :date_played.lt => (params['year'].to_i+1).to_s})
    render
  end
  
end
