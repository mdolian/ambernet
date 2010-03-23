class SearchController < ApplicationController

  def advanced_search_results
    @current_page = (params[:page] || 1).to_i
    error_message, notice_message = "",""    

    @shows = Show.search(params, @current_page, 25)

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
