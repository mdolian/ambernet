class BrowseController < ApplicationController

  def index
    render
  end
  
  def browse
    @current_page = (params[:page] || 1).to_i
    error_message, notice_message = "",""

    if params["browse"] == "recording"
      @recordings = Recording.by_recording_type(params["recording_type"])
      @display_recordings, @display_shows = true, false
   else 
      @display_shows = params["display"] == "shows" ? true : false
      @display_recordings = params["display"] == "recordings" ? true : false    
    
      @shows = Show.order("date_played desc").group("shows.id").joins(:venue, :setlists) if @display_shows == true
      @recordings = Recording.order("date_played desc").group("recordings.id").joins(:show).group("shows.date_played")      if @display_recordings == true
    
      if params["browse"] == "date"
        end_date = params["end_date"] == '' ? Date.today : Date.parse(params["end_date"])
        start_date = params["start_date"] == '' ? Date.today : Date.parse(params["start_date"])
      
        error_message = "Start date later than end date"            if (end_date < start_date)
        @shows = @shows.by_date(start_date, end_date)               if @display_shows == true
        @recordings = @recordings.by_date(start_date, end_date)     if @display_recordings == true
      end  
    
      if params["browse"] == "venues"
        @shows = @shows.where("venue_id IN (?)", params["as_values_venues"].split(","))             if @display_shows == true
        @recordings = @recordings.where("venue_id IN (?)", params["as_values_venues"].split(","))   if @display_recordings == true
      end
    
      if params["browse"] == "songs"
        @shows = @shows.where("setlists.song_id IN (?)", params["as_values_songs"].split(","))             if @display_shows == true
        @recordings = @recordings.where("setlists.song_id IN (?)", params["as_values_songs"].split(","))   if @display_recordings == true
      end
    end
    
    @shows = @shows.paginate :all, :page => @current_page, :per_page => 25              if @display_shows == true
    @recordings = @recordings.paginate :all, :page => @current_page, :per_page => 25    if @display_recordings == true
    
    render
  end
  
end
