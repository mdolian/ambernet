require 'date'
require 'zip/zip'
require 'zip/zipfilesystem'

class Recordings < Application

  before :ensure_authenticated, :only => [:admin, :new, :create, :edit, :delete, :update]
  
  params_accessible :post => [:label, :source, :lineage, :taper, :transfered_by, :notes, :type, :show_id, :page, :song_name, :filetype,
                              :year, :start_date, :end_date, :id, :submit, :venue_name, :venue_city, :venue_state, :submit, :shnid]


  # Admin does not use tab ajax browsing so the layout is required
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
  
  def delete
    Recording.get(params["id"]).destroy
    redirect "/recordings/admin"
  end
    
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
      redirect "/recordings/admin"
    else  
       @recording = Recording.get(params["id"])
       render 
    end
  end
  
  def new
    render 
  end

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
    redirect "/recordings/admin"
  end  

  # The user views require  :layout => false because they are called by the JQuery UI Tabs by Ajax

  def index
    render :layout => false
  end
 
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
  
  def show
    @recording = Recording.get(params["id"])
    # @recording_tracks = RecordingTrack.all(:recording_id => params["id"])
    render :layout => false
  end
    
  def search_results
    @current_page = (params[:page] || 1).to_i
    conditions = {}
    error_message, notice_message = ""

    if params["submit"] != nil
      conditions.merge!({:type => params["type"]})                                                          if params["type"] != 'all'
      conditions.merge!({:shnid => params["shnid"]})                                                        if params["shnid"] != ''      
      conditions.merge!({:label.like => "%" << params["label"] << "%"})                                     if params["label"] != ''
      conditions.merge!({:source.like => "%" << params["source"] << "%"})                                   if params["source"] != ''
      conditions.merge!({:lineage.like => "%" << params["lineage"] << "%"})                                 if params["lineage"] != ''
      conditions.merge!({:taper.like => "%" << params["taper"] << "%"})                                     if params["taper"] != ''
      conditions.merge!({Recording.show.date_played.gte => params["year"], 
                                     Recording.show.date_played.lt => (params["year"].to_i+1).to_s})        if params["year"] != 'All'
      conditions.merge!({Recording.show.venue.venue_name.like => "%" << params["venue_name"] << "%"})       if params["venue_name"] != ''
      conditions.merge!({Recording.show.venue.venue_city.like => "%" << params["venue_city"] << "%"})       if params["venue_city"] != ''
      conditions.merge!({Recording.show.venue.venue_state.like => "%" << params["venue_state"] << "%"})     if params["venue_state"] != ''
      #conditions.merge!({Recording.show.setlists.song.song_name.like => "%" << params["song_name"] << "%"}) if params["song_name"] != ''

      unless (params["end_date"] == '' && params["start_date"] == '')
        end_date = params["end_date"] == '' ? Date.today : Date.parse(params["end_date"])       
        start_date = params["start_date"] == '' ? Date.today : Date.parse(params["start_date"])
        error_message = "Start date later than end date" if (end_date < start_date)   
         
        conditions.merge!({Recording.show.date_played.gte => params["start_date"], 
                                       Recording.show.date_played.lte => params["end_date"]})      
      end
    else
      conditions = session[:conditions]
    end
    
    error_message = "Please select at least one search filter" if conditions.empty?  
    
    @page_count, @recordings = Recording.paginated(
      :page => @current_page,
      :per_page => 50,
      :conditions => conditions)                               if error_message == ''  
    #notice_message = "No recordings were found"                if @recordings.count == 0  
    session[:conditions] = conditions                          if error_message == ''
    session[:searchBranch] = "recordings"                      if error_message == ''  
    session[:current_page] = @current_page                     if error_message == ''    
    message[:error] = error_message                            if error_message != ''
    message[:notice] = notice_message                          if notice_message != ''
    render :layout => false
  end
  
  def zip
    only_provides :zip
    @recording = Recording.get(params["id"])
    t = Tempfile.new("zips/#{@recording.id}-#{request.remote_ip}.zip")
    Zip::ZipOutputStream.open(t.path) do |zos|
      @recording.files(params["type"]) do |file|
        zos.put_next_entry(File.basename(file.path))
        zos.print IO.read(file.path)
        Merb.logger.debug "File added to zip: #{file.path}"    
      end
    end
    Merb.logger.debug "Temp Zip Path: #{t.path}"
    send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => "#{@recording.label}.#{params['type']}.zip"
    t.close    
  end

end