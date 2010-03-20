class SearchController < ApplicationController

  def search_results
    @current_page = (params[:page] || 1).to_i
    
    @recordings = Recording.label(params["label"]).lineage(params["linage"]).taper(params["taper"])
    @recordings = @recordings.shnid(params["shnid"])  if params["shnid"] != ''
    @recordings.collect!
    
    @shows = Show.venue_city(params["venue_city"]).venue_state(params["venue_state"]).collect
  end
    

    # Search shows  
    def search_shows
      if request.method == :get
        render
      else

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

        render :search_results
      end

    end
    # search results action    
    def search_recordings
      if request.method == :get
        render
      else
        @current_page = (params[:page] || 1).to_i

        conditions = {}
        error_message, notice_message = ""

        if params["submit"] != nil
          # Need to get drop downs working in views
          conditions.merge!({:recording_type => params["recording_type"]})              if params["recording_type"] != 'all'
          conditions.merge!({:shnid => params["shnid"]})                                if params["shnid"] != ''      
          conditions.merge!({:label => params["label"], :star => true})                 if params["label"] != ''
          conditions.merge!({:source => params["source"], :star => true})               if params["source"] != ''
          conditions.merge!({:lineage => params["lineage"], :star => true})             if params["lineage"] != ''
          conditions.merge!({:taper => params["taper"], :star => true})                 if params["taper"] != ''
          conditions.merge!({:venue_name => params["venue_name"], :star => true})       if params["venue_name"] != ''
          conditions.merge!({:venue_city => params["venue_city"], :star => true})       if params["venue_city"] != ''
          conditions.merge!({:venue_state => params["venue_state"], :star => true})     if params["venue_state"] != ''
          conditions.merge!({:song_name => params["song_name"], :star => true})         if params["song_name"] != ''

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
          @recordings = Recording.paginate(:conditions => conditions, :page => @current_page, 
                                           :order => :date_played, :sort_mode => :asc)                
          session[:conditions] = conditions 
        end

        if error_message != ''
          flash.now[:error] = error_message
          flash.now[:notice] = notice_message
        end

      render :search_results

      end

    end

end
