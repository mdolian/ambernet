require 'date'
 
class ShowsController < ApplicationController
 
  # From Merb, to be implemented
  #before :ensure_authenticated, :only => [:admin, :new, :create, :edit, :delete, :update]
  #params_accessible :post => [:date_played, :sid, :page, :year, :start_date, :end_date, :submit,
  # :venue_name, :venue_city, :venue_state, :song_name, :method]
 
 
  def index
    render
  end
  
  def list
    list = []
    shows = Show.all(["date_played = " << Date.strptime(params["date_played"])])
    shows.each do |show|
      list << {"label" => show.label, "id" => show.id}
    end
    render :json => list.to_json, :layout => false
  end
 
  def setlist
    setlist_json = []
    total_sets = Show.find(params["id"]).setlists[0].total_sets
    Show.find(params["id"]).setlists.each do |setlist|
      song = Song.find(setlist.song_id)
      setlist_json << {"set_id" => setlist.set_id, "song_order" => setlist.song_order, "song_name" => song.song_name, "segue" => setlist.song_suffix, "total_sets" => total_sets}
    end
    render :json => setlist_json.to_json, :layout => false
  end
 
  def recordings
    @recordings = Recording.all(:show_id => params["id"])
    render :layout => false
  end
    
  def search_results
    @current_page = (params[:page] || 1).to_i
    conditions = {}
    error_message, notice_message = "",""
    
    if params["submit"] != nil
      conditions.merge!({:song_name => params["song_name"], :star => true})                           if params["song_name"] != ''
      conditions.merge!({:date_played => params["year"].to_date..(params["year"].to_i+1).to_date})    if params["year"] != 'All'
      conditions.merge!({:venue_city => params["venue_city"], :star => true})                         if params["venue_city"] != ''
      conditions.merge!({:venue_state => params["venue_state"], :star => true})                       if params["venue_state"] != ''
      conditions.merge!({:venue_name => params["venue_name"], :star => true})                         if params["venue_name"] != ''
 
      unless (params["end_date"] == '' && params["start_date"] == '')
        end_date = params["end_date"] == '' ? Date.today : Date.parse(params["end_date"])
        start_date = params["start_date"] == '' ? Date.today : Date.parse(params["start_date"])
        error_message = "Start date later than end date" if (end_date < start_date)
        conditions.merge!({:date_played  => start_date..end_date})
      end
    else
      conditions = session[:conditions]
    end
    
    error_message = "Please select at least one search filter" if conditions.empty?
    
    if error_message == ''
    
      @shows = Show.search(:conditions => conditions, :page => @current_page, 
                           :order => :date_played, :sort_mode => :asc)  
      session[:conditions] = conditions                        
      session[:current_page] = @current_page
    end
    
    if error_message != ''
      flash[:error] = error_message
      flash[:notice] = notice_message
    end
    
    render
 
  end
 
end