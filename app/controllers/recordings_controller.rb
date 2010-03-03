class RecordingsController < ApplicationController

  #before_filter :authenticate_user!, :except => [:search, :stream, :zip, :show]

  def index
    @current_page = (params[:page] || 1).to_i 
    @recordings = Recording.paginate(:joins => {:show => :venue}, :page => @current_page) 

    respond_to do |format|
      format.html
      format.xml  { render :xml => @recordings }
    end
  end

  def show
    @recording = Recording.find(params["id"])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @recording }
    end
  end 
 
  def new
    @recording = Recording.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @recording }
    end
  end

  def edit
    @recording = Recording.find(params["id"])
  end

  def create 
    @recording = Recording.new(params[:recording])

    tracking_info = params["discs"] << "["
    for i in (1..params["discs"].to_i)
      tracking_info << params["tracksDisc" << i.to_s] << ","
    end
    tracking_info.chop! << "]"
    params["tracking_info"] = tracking_info    
    
    respond_to do |format|
      if @recording.save
        flash[:notice] = 'Recording was successfully created.'
        format.html { redirect_to :action => "index" }
        format.xml  { render :xml => @recording, :status => :created, :location => @recording }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recording.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @recording = Recording.find(params["id"])
   
    tracking_info = params["discs"] << "["
    for i in (1..params["discs"].to_i) 
      tracking_info << params["tracksDisc" << i.to_s] << ","
    end
    tracking_info.chop! << "]"
    params["tracking_info"] = tracking_info
     
    respond_to do |format|
      if @recording.update_attributes(params[:recording])
        flash[:notice] = "Recording was successfully updated."
        format.html { redirect_to :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recording.errors, :status => :unprocessable_entity }
      end
    end    
  end

  def destroy
    @recording = Recording.find(params[:id])
    @recording.destroy

    respond_to do |format|
      flash[:notice] = "Recording was successfully deleted."
      format.html { redirect_to :action => "index" }
      format.xml  { head :ok }
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
  def search
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
  
  # Rate a show via ajax call
  def rate
    Recording.update(params["id"], {:rating => params["rating"]})
  end
  
  # TO-DO - convert to Rails
  def zip
    only_provides :zip
    @recording = Recording.find(params["id"])
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
    
    #headers['Content-Disposition'] = "attachment; filename = #{@recording.label}.#{params['type']}.zip"
    #headers['Content-Type'] = "application/zip"
    
    #respond_to do |format|
    #  format.zip
    #end
    
    # TO-DO - This will be replaced by resque
    # Need to implement, this was a Merb function
    #nginx_send_file "/ambernet/zips/#{@recording.label}.#{params['type']}.zip" 
  end

end