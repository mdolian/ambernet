require 'date'
require 'zip/zip'
require 'zip/zipfilesystem'

class Recordings < Application

  before :ensure_authenticated, :only => [:admin, :new, :create, :edit, :delete, :update]
  
  params_accessible :post => [:label, :source, :lineage, :taper, :transfered_by, :notes, :type, :show_id, :page, :song_name, :filetype,
                              :year, :start_date, :end_date, :id, :submit, :venue_name, :venue_city, :venue_state, :submit, :shnid]

  provides :pls
  
  def admin
    @current_page = (params[:page] || 1).to_i
    @page_count, @recordings = Recording.paginated(
      :page => @current_page,
      :per_page => 100)    
    render
  end
  
  def delete
    Recording.get(params["id"]).destroy
    @current_page = (params[:page] || 1).to_i
    @page_count, @recordings = Recording.paginated(
      :page => @current_page,
      :per_page => 100)    
    render :admin
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
      @current_page = (params[:page] || 1).to_i
      @page_count, @recordings = Recording.paginated(
        :page => @current_page,
        :per_page => 100)                                                                                             
      render :admin
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
    render :admin
  end  

  def index
    render
  end
 
  def stream
    if params["id"].length > 4 
      stream = ""
      if Recording.count(Recording.show.date_played => params["id"]) > 0
        Recording.all(Recording.show.date_played => params["id"]).each do |recording|
          stream << params["format"] == "pls" ? recording.to_pls : recording.to_m3u << "\n\n"
        end
      else
        render "Sorry, no show exists for that date"
      end
    else
      stream = params["format"] == "pls" ? Recording.get(params["id"]).to_pls : Recording.get(params["id"]).to_m3u
    end
    render stream, :layout => false
  end
  
  def show
    @recording = Recording.get(params["id"])
    # @recording_tracks = RecordingTrack.all(:recording_id => params["id"])
    render
  end
  
  def download
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
      :per_page => 100,
      :conditions => conditions)                               if error_message == ''  
    #notice_message = "No recordings were found"                if @recordings.count == 0  
    session[:conditions] = conditions                          if error_message == ''  
    message[:error] = error_message                            if error_message != ''
    message[:notice] = notice_message                          if notice_message != ''
    render

  end
  
  def zip
    only_provides :zip
    @recording = Recording.get(params["id"])   
    type = @recording.download_extension(params["type"]) 
    t = Tempfile.new("tempzip-#{@recording.label}")
    Merb.logger.debug("Temp File: #{t.path}")
    # Give the path of the temp file to the zip outputstream, it won't try to open it as an archive.
    Zip::ZipOutputStream.open(t.path) do |zos|
      for i in 1..@recording.discs.to_i do
        for j in "01"..@recording.tracks(i) do
          trackname = @recording.show.date_as_label + "d" + i.to_s + "t" + j.to_s + "." + type
          file = File.open("/ambernet/#{@recording.label}/pgroove" + trackname)
          zos.put_next_entry(trackname)
          Merb.logger.debug "File added to zip: #{filename}"
          zos.print IO.read(file.path)
        end
      end
    end
    # End of the block  automatically closes the file.
    # Send it using the right mime type, with a download window and some nice file name.
    send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => "#{@recording.label}.#{type}.zip"
    # The temp file will be deleted some time...
    t.close    
  end
  
  def zip2
    provides :zip
    @recording = Recording.get(params["id"])   
    type = @recording.download_extension(params["type"])    
    dir = "/ambernet/#{@recording.label}/"
    Zippy.create 'blah.zip' do |zip|
      Dir['#{dir}/*.#{type}'].each do |filename|
        zip[filename] = File.open(filename)
      end
      render zip.data 
    end   
  end

end