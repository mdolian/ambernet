class SearchController < ApplicationController

  def search_results
    @current_page = (params[:page] || 1).to_i
    error_message, notice_message = "",""    
    
    @shows = Show.order("date_played desc")
    @shows = @shows.by_venue_city(params["venue_city"])                               if params["venue_city"] != ''
    @shows = @shows.by_venue_state(params["venue_state"])                             if params["venue_state"] != ''
    @shows = @shows.by_date(params["year"].to_date, (params["year"].to_i+1).to_date)  if params["year"] != 'All'
    @shows = @shows.by_venue_name(params["venue_name"])                               if params["venue_name"] != ''
    @shows = @shows.by_song(params["song_name"])                                      if params["song_name"] != ''
    @shows = @shows.by_recording_type(params["recording_type"])                       if params["recording_type"] != 'all'
    @shows = @shows.by_shnid(params["shnid"])                                         if params["shnid"] != '' 
    @shows = @shows.by_label(params["label"])                                         if params["label"] != ''
    @shows = @shows.by_source(params["source"])                                       if params["source"] != ''
    @shows = @shows.by_lineage(params["lineage"])                                     if params["lineage"] != ''
    @shows = @shows.by_taper(params["taper"])                                         if params["taper"] != ''
    
    unless (params["end_date"] == '' && params["start_date"] == '')
      end_date = params["end_date"] == '' ? Date.today : Date.parse(params["end_date"])
      start_date = params["start_date"] == '' ? Date.today : Date.parse(params["start_date"])
      error_message = "Start date later than end date" if (end_date < start_date)
      @shows = @shows.by_date(start_date, end_date)
    end

    if error_message != ''
      flash[:error] = error_message
      flash[:notice] = notice_message
    end
    
    @shows.collect!
    render
        
  end
    
end
