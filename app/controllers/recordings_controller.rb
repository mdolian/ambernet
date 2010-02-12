require 'date'
require 'zip/zip'
require 'zip/zipfilesystem'

class RecordingsController < ApplicationController

  # TO-DO - implement below
  #before :ensure_authenticated, :only => [:admin, :new, :create, :edit, :delete, :update]
  #params_accessible :post => [:label, :source, :lineage, :taper, :transfered_by, :notes, :type, :show_id, :page, :song_name, :filetype,
  #                            :year, :start_date, :end_date, :id, :submit, :venue_name, :venue_city, :venue_state, :submit, :shnid]


  # Admin actions

  # loads the admin page, a list of recordings given a year
  def admin
    if params["year"] != nil
      conditions = {:label.not => nil}
      conditions.merge!({Recording.show.date_played.gte => params["year"], 
                         Recording.show.date_played.lt => (params["year"].to_i+1).to_s})   if params["year"] != "All"
      @recordings = Recording.all(:conditions => conditions)    
        render :admin
    else
      render :year_list
    end
  end

  # deletes a recording  
  def delete
    Recording.get(params["id"]).destroy
    redirect_to "/recordings/admin"
  end
  
  # update a recording
  def edit
    if params["submit"] == 'Update'
      tracking_info = params["discs"] << "["
      for i in (1..params["discs"].to_i) 
        tracking_info << params["tracksDisc" << i.to_s] << ","
      end
      tracking_info.chop! << "]"    
      @recording = Recording.get(params["id"])
      @recording.update_attributes( :label => params["label"],
                                    :source => params["source"],
                                    :lineage => params["lineage"],
                                    :taper => params["taper"],
                                    :transfered_by => params["transfered_by"],
                                    :notes => params["notes"],
                                    :type => params["type"],
                                    :filetype => params["filetype"],
                                    :shnid => params["shnid"],
                                    :tracking_info => tracking_info)                                                                                             
      redirect_to "/recordings/admin"
    else  
       @recording = Recording.get(params["id"])
       render 
    end
  end
 
  # form to create a new recording  
  def new
    render 
  end
  
  # insert a new recording into the database
  def create
    tracking_info = params["discs"] << "["
    for i in (1..params["discs"].to_i)
      tracking_info << params["tracksDisc" << i.to_s] << ","
    end
    tracking_info.chop! << "]"    
    @recording = Recording.new(
      :show_id => params["show_id"],
      :label => params["label"],
      :source => params["source"] == "" ? "unknown" : params["source"],
      :lineage => params["lineage"] == "" ? "unknown" : params["lineage"],
      :taper => params["taper"] == "" ? "unknown" : params["taper"],
      :transfered_by => params["transfered_by"] == "" ? "unknown" : params["transfered_by"],
      :notes => params["notes"],
      :type => params["type"],
      :filetype => params["filetype"],
      :shnid => params["shnid"],
      :tracking_info => tracking_info
    )
    @recording.save
    @current_page = (params[:page] || 1).to_i
    @page_count, @recordings = Recording.paginated(
      :page => @current_page,
      :per_page => 100)    
    redirect_to "/recordings/admin"
  end  



  # User actions
  # action for the search form page
  def index
    render
  end

  # TO-DO - convert to Rails
  # streams a recording
  def stream
    only_provides :pls, :m3u
    format, id = params["format"], params["id"]
    if params["id"].length > 4 
      stream = ""
      if Recording.count(Recording.show.date_played => id) > 0
        Recording.all(Recording.show.date_played => id).each do |recording|
          stream << format == "pls" ? recording.to_pls : recording.to_m3u << "\n\n"
        end
      else
        render "Sorry, no show exists for that date", :layout => false
      end
    else
      stream = params["format"] == "pls" ? Recording.get(params["id"]).to_pls : Recording.get(params["id"]).to_m3u
      label = Recording.get(params["id"]).label
    end
    content_type = "application/m3u" if params["format"] == "m3u"
    content_type = "application/pls" if params["format"] == "pls"
    filename = "#{label}.#{format}"
    send_data stream, :type => content_type, :disposition => 'attachment', :filename => filename
  end

  # recording details action
  def show
    @recording = Recording.get(params["id"])
    render
  end
 
  # search results action    
  def search_results
    @current_page = (params[:page] || 1).to_i
    
    conditions = {}
    error_message, notice_message = ""

    if params["submit"] != nil
      # Need to get drop downs working in views
      #conditions.merge!({:type => params["type"]})                                                          if params["type"] != 'all'
      #conditions.merge!({:shnid => params["shnid"]})                                                        if params["shnid"] != ''      
      #conditions.merge!({:label.like => "%" << params["label"] << "%"})                                     if params["label"] != ''
      #conditions.merge!({:source.like => "%" << params["source"] << "%"})                                   if params["source"] != ''
      #conditions.merge!({:lineage.like => "%" << params["lineage"] << "%"})                                 if params["lineage"] != ''
      #conditions.merge!({:taper.like => "%" << params["taper"] << "%"})                                     if params["taper"] != ''
      #conditions.merge!({"show.date_played >= #{params['year']} AND show.date_played < (#{params['year'].to_i+1).to_s}"})        if params["year"] != 'All'
      #conditions.merge!({Recording.show.venue.venue_name.like => "%" << params["venue_name"] << "%"})       if params["venue_name"] != ''
      #conditions.merge!({Recording.show.venue.venue_city.like => "%" << params["venue_city"] << "%"})       if params["venue_city"] != ''
      #conditions.merge!({Recording.show.venue.venue_state.like => "%" << params["venue_state"] << "%"})     if params["venue_state"] != ''
      #conditions.merge!({Recording.show.setlists.song.song_name.like => "%" << params["song_name"] << "%"}) if params["song_name"] != ''

      #unless (params["end_date"] == '' && params["start_date"] == '')
      #  end_date = params["end_date"] == '' ? Date.today : Date.parse(params["end_date"])       
      #  start_date = params["start_date"] == '' ? Date.today : Date.parse(params["start_date"])
      #  error_message = "Start date later than end date" if (end_date < start_date)   
         
      #  conditions.merge!({Recording.show.date_played.gte => params["start_date"], 
       #                                Recording.show.date_played.lte => params["end_date"]})      
      #end 
    else
      conditions = session[:conditions]
    end
    
    error_message = "Please select at least one search filter" if conditions.empty?  
    
    # Need to implement mislav's will_paginate
    #@page_count, @recordings = Recording.paginated(
    #  :page => @current_page,
    #  :per_page => 50,
    
    @recordings = Recording.paginate(
      :page => @current_page, 
      :conditions => conditions)                if error_message == ''
    #notice_message = "No recordings were found" if @recordings.count == 0  
    session[:conditions] = conditions           if error_message == '' 
    flash.now[:error] = error_message           if error_message != ''
    flash.now[:notice] = notice_message         if notice_message != ''
    render
  end
  
  # TO-DO - convert to Rails
  def zip
    only_provides :zip
    @recording = Recording.get(params["id"])
    if !File.exist?("public/ambernet/zips/#{@recording.label}.#{params['type']}.zip")
      t = File.open("public/ambernet/zips/#{@recording.label}.#{params['type']}.zip", "w")
      Zip::ZipOutputStream.open(t.path) do |zos|
        @recording.files(params["type"]) do |file|
          zos.put_next_entry(File.basename(file.path))
          zos.print IO.read(file.path)
          logger.debug "File added to zip: #{file.path}"    
        end
      end
      logger.debug "Temp Zip Path: /zips/#{File.basename(t.path)}"
      t.close   
    end
    
    headers['Content-Disposition'] = "attachment; filename = #{@recording.label}.#{params['type']}.zip"
    headers['Content-Type'] = "application/zip"
    
    # Need to implement, this was a Merb function
    #nginx_send_file "/ambernet/zips/#{@recording.label}.#{params['type']}.zip" 
  end

end