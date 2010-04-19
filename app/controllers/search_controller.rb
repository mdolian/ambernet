class SearchController < ApplicationController

  def advanced_search_results
    @current_page, error_message = (params[:page] || 1).to_i, ""
    
    @shows = Show.order("date_played desc").group("shows.id")  
    @shows = @shows.by_songs params["as_values_songs"].chop!.split(",")       if params["as_values_songs"] != "" 
    @shows = @shows.by_venues params["as_values_venues"].chop!.split(",")     if params["as_values_venues"] != ""
    @shows = @shows.by_venue_city params["venue_city"]                        if params["venue_city"] != "Enter City" && params["venue_city"] != ""
    @shows = @shows.by_venue_state params["venue_state"]                      if params["venue_state"] != "all"
    @shows = @shows.by_label params["label"]                                  if params["label"] != ""
    @shows = @shows.by_source params["source"]                                if params["source"] != ""
    @shows = @shows.by_lineage params["lineage"]                              if params["lineage"] != ""
    @shows = @shows.by_taper params["taper"]                                  if params["taper"] != ""
    @shows = @shows.by_shnid params["shnid"]                                  if params["shnid"] != ""
    @shows = @shows.by_recording_type params["recording_type"]                if params["recording_type"] != "all"
    

    unless (params["end_date"] == '' && params["start_date"] == '')
      end_date = params["end_date"] == '' ? Date.today : Date.parse(params["end_date"])
      start_date = params["start_date"] == '' ? Date.today : Date.parse(params["start_date"])
      error_message = "Start date later than end date" if (end_date < start_date)
      @shows = @shows.by_date(start_date, end_date)
    end

    flash[:error] = error_message   if error_message != ''
  
    @shows = @shows.paginate :all, :page => @current_page, :per_page => 25
  
    render :search_results
        
  end
  
  def simple_search_results  
    @current_page = (params[:page] || 1).to_i   
    
    @shows = Show.order("date_played desc").group("shows.id").joins(:setlists, :songs, :venue)
    @shows = @shows.by_venue_city(params["search"])     if Show.by_venue_city(params["search"]).count > 0
    @shows = @shows.by_venue_state(params["search"])    if Show.by_venue_state(params["search"]).count > 0
    @shows = @shows.by_venue_name(params["search"])     if Show.by_venue_name(params["search"]).count > 0                   
    @shows = @shows.by_song(params["search"])           if Show.by_song(params["search"]).count > 0
    @shows = @shows.by_label(params["search"])          if Show.by_label(params["search"]).count > 0
    @shows = @shows.by_source(params["search"])         if Show.by_source(params["search"]).count > 0                     
    @shows = @shows.by_lineage(params["search"])        if Show.by_lineage(params["search"]).count > 0                
    @shows = @shows.by_taper(params["search"])          if Show.by_taper(params["search"]).count > 0                     
    
    @shows = @shows.paginate :page => @current_page, :per_page => 25
    render :search_results

  end
end
