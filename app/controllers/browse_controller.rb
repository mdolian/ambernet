class BrowseController < ApplicationController

  def index
    render
  end
  
  def browse
    @current_page, error_message = (params[:page] || 1).to_i, ""

    if params["done"] == ""
      render
    else 
      @shows = Show.order("date_played desc").group("shows.id").joins(:venue, :setlists)
    
      if params["browse"] == "date"
        end_date = params["end_date"] == '' ? Date.today : Date.parse(params["end_date"])
        start_date = params["start_date"] == '' ? Date.today : Date.parse(params["start_date"])
      
        error_message = "Start date later than end date" if (end_date < start_date)
        @shows = @shows.by_date start_date, end_date
      end  
    
      @shows = @shows.by_venues  params["as_values_venues"].chop!.split(",")            if params["browse"] == "venues"
      @shows = @shows.by_songs params["as_values_songs"].chop!.split(",")               if params["browse"] == "songs"

      @shows = @shows.paginate :all, :page => @current_page, :per_page => 25
      
      render
    end

  end
  
end
