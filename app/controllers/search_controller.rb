class SearchController < ApplicationController

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

    # streams a recording
    def stream
      only_provides :pls, :m3u
      format, id = params["format"], params["id"]
      if params["id"].length > 4 
        stream = ""
        if Recording.count(:join => :shows, conditions => {:date_played => id}) > 0
          Recording.all(:date_played => id).each do |recording|
            stream << format == "pls" ? recording.to_pls : recording.to_m3u << "\n\n"
          end
        else
          render "Sorry, no show exists for that date", :layout => false
        end
      else
        stream = params["format"] == "pls" ? Recording.find(params["id"]).to_pls : Recording.find(params["id"]).to_m3u
        label = Recording.find(params["id"]).label
      end
      content_type = "application/m3u" if params["format"] == "m3u"
      content_type = "application/pls" if params["format"] == "pls"
      filename = "#{label}.#{format}"
      send_data stream, :type => content_type, :disposition => 'attachment', :filename => filename
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
